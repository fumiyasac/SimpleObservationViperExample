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
    func getGalleries() async throws -> [GalleryPhotoEntity]
    func getPickupFeeds() async throws -> [PickupFeedEntity]
    func getCategoryFeeds() async throws -> [CategoryRankingEntity]
    func getInformationFeedPage(_ page: Int) async throws -> [InformationFeedPageEntity]
    func generateAccessToken(email: String, password: String) async throws -> AccessTokenEntity
    func verifyAccessToken() async throws -> AccessTokenEntity
}

final class APIClientManager {

    // MARK: - Singleton Instance

    static let shared = APIClientManager()

    private init() {}

    // MARK: - Enum

    private enum EndPoint: String {

        case galleries = "galleries"
        case pickupFeeds = "pickup_feeds"
        case categoryFeeds = "category_feeds"
        case infoFeeds = "info_feed"
        case authLogin = "auth/login"
        case authVerify = "auth/verify"

        func getBaseUrl() -> String {
            return [host, version, self.rawValue].joined(separator: "/")
        }
    }

    // MARK: - Property

    // MEMO: API ServerへのURLに関する情報
    private static let host = "http://localhost:3001"
    private static let version = "v1"

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

        // MEMO: 認可用アクセストークンをセットする（本サンプルでは利用せずともリクエスト可能）
        let authraizationHeader = KeychainAccessManager.shared.getAuthenticationHeader()
        if !authraizationHeader.isEmpty {
            urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        }
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

        // MEMO: 認可用アクセストークンをセットする（本サンプルでは利用せずともリクエスト可能）
        let authraizationHeader = KeychainAccessManager.shared.getAuthenticationHeader()
        if !authraizationHeader.isEmpty {
            urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}

// MARK: - ApiClientManagerProtocol

extension APIClientManager: APIClientManagerProtocol {

    func getGalleries() async throws -> [GalleryPhotoEntity] {
        try await executeAPIRequest(
            endpointUrl: EndPoint.galleries.getBaseUrl(),
            httpMethod: .GET,
            responseFormat: [GalleryPhotoEntity].self
        )
    }

    func getPickupFeeds() async throws -> [PickupFeedEntity] {
        try await executeAPIRequest(
            endpointUrl: EndPoint.pickupFeeds.getBaseUrl(),
            httpMethod: .GET,
            responseFormat: [PickupFeedEntity].self
        )
    }

    func getCategoryFeeds() async throws -> [CategoryRankingEntity] {
        try await executeAPIRequest(
            endpointUrl: EndPoint.categoryFeeds.getBaseUrl(),
            httpMethod: .GET,
            responseFormat: [CategoryRankingEntity].self
        )
    }

    func getInformationFeedPage(_ page: Int) async throws -> [InformationFeedPageEntity] {
        try await executeAPIRequest(
            endpointUrl: EndPoint.infoFeeds.getBaseUrl(),
            withParameters: ["page": page],
            httpMethod: .GET,
            responseFormat: [InformationFeedPageEntity].self
        )
    }

    func generateAccessToken(email: String, password: String) async throws -> AccessTokenEntity {
        try await executeAPIRequest(
            endpointUrl: EndPoint.authLogin.getBaseUrl(),
            withParameters: ["email": email, "password": password],
            httpMethod: .POST,
            responseFormat: AccessTokenEntity.self
        )
    }

    func verifyAccessToken() async throws -> AccessTokenEntity {
        try await executeAPIRequest(
            endpointUrl: EndPoint.authVerify.getBaseUrl(),
            httpMethod: .POST,
            responseFormat: AccessTokenEntity.self
        )
    }
}
