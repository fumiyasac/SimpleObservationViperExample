//
//  APIClientManager.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/10/28.
//

import Foundation

// MARK: - Enum

// MEMO: APIエラーメッセージに関するEnum定義
enum APIError: Error {
    case error(message: String)
}

// MEMO: APIリクエスト状態に関するEnum定義
enum APIRequestState {
    case none
    case requesting
    case success
    case error
}

// MEMO: APIリクエストに関するEnum定義
enum HTTPMethod {
    case GET
    case POST
}

// MARK: - Protocol

protocol APIClientManagerProtocol {
    
    // MEMO: APIClientManagerはasync/awaitを利用して書く
}

final class ApiClientManager {

    // MARK: - Singleton Instance

    static let shared = ApiClientManager()

    private init() {}

    // MARK: - Enum

    private enum EndPoint: String {

        case foodPhotos = "pickup_foods"
        case recentNews = "recent_news"

        func getBaseUrl() -> String {
            return [host, self.rawValue].joined(separator: "/")
        }
    }

    // MARK: - Property

    // MEMO: API ServerへのURLに関する情報
    private static let host = "http://localhost:3000"

    // MARK: - Function

    func executeAPIRequest<T: Decodable>(endpointUrl: String, withParameters: [String : Any] = [:], httpMethod: HTTPMethod = .GET, responseFormat: T.Type) async throws -> T {

        // MEMO: API通信用のリクエスト作成する（※現状はGET/POSTのみの機構を準備）
        var urlRequest: URLRequest
        switch httpMethod {
        case .GET:
            urlRequest = makeGetRequest(endpointUrl, withParameters: withParameters)
        case .POST:
            urlRequest = makePostRequest(endpointUrl, withParameters: withParameters)
        }
        return try await handleAPIRequest(responseType: T.self, urlRequest: urlRequest)
    }

    // MARK: - Private Function

    private func handleAPIRequest<T: Decodable>(responseType: T.Type, urlRequest: URLRequest) async throws -> T {

        // Step1: API Mock Serverへのリクエストを実行する
        let (data, response) = try await executeUrlSession(urlRequest: urlRequest)
        // Step2: 受け取ったResponseを元にハンドリングする
        let _ = try handleErrorByStatusCode(urlRequest: urlRequest, response: response)
        // Step3: JSONをEntityへMappingする
        return try decodeDataToJson(data: data)
    }

    // URLSessionを利用してAPIリクエスト処理を実行する
    // MEMO: URLSession.shared.data(for: urlRequest)はiOS15から利用可能なメソッドである点に注意
    private func executeUrlSession(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw APIError.error(message: "No network connection.")
        }
    }

    // レスポンスで受け取ったStatusCodeを元にエラーか否かをハンドリングする
    private func handleErrorByStatusCode(urlRequest: URLRequest, response: URLResponse) throws {
        let urlString = String(describing: urlRequest.url?.absoluteString)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.error(message: "No http response (\(urlString)).")
        }
        switch httpResponse.statusCode {
        case 200...399:
            break
        case 400:
            throw APIError.error(message: "Bad Request (\(urlString)).")
        case 401:
            throw APIError.error(message: "Unauthorized (\(urlString)).")
        case 403:
            throw APIError.error(message: "Forbidden (\(urlString)).")
        case 404:
            throw APIError.error(message: "Not Found (\(urlString)).")
        default:
            throw APIError.error(message: "Unknown (\(urlString)).")
        }
    }

    // レスポンスで受け取ったData(JSON)をDecodeしてEntityに変換する
    private func decodeDataToJson<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.error(message: "Failed decode data.")
        }
    }

    // GETリクエストを作成する
    private func makeGetRequest(_ urlString: String, withParameters: [String : Any] = [:]) -> URLRequest {

        // withParametersから受け取った値をクエリパラメータで処理する
        var urlComponents = URLComponents(string: urlString)
        var targetQueryItems: [URLQueryItem] = []
        for (key, value) in withParameters {
            targetQueryItems.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        if !targetQueryItems.isEmpty {
            urlComponents?.queryItems = targetQueryItems
        }

        guard let url = urlComponents?.url else {
            fatalError("Invalid URL strings.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // MEMO: 本来であれば認可用アクセストークンをセットする
        let authraizationHeader = ""
        urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        return urlRequest
    }

    // POSTリクエストを作成する
    private func makePostRequest(_ urlString: String, withParameters: [String : Any] = [:]) -> URLRequest {

        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL strings.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        // MEMO: Dictionaryで取得したリクエストパラメータをJSONに変換する
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: withParameters, options: [])
            urlRequest.httpBody = requestBody
        } catch {
            fatalError("Invalid request body parameters.")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // MEMO: 本来であれば認可用アクセストークンをセットする
        let authraizationHeader = ""
        urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

// MARK: - ApiClientManagerProtocol

extension ApiClientManager: APIClientManagerProtocol {}
