//
//  AuthenticationInteractor.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

final class AuthenticationInteractor: AuthenticationInteractorProtocol {

    // MARK: - Function

    func login(email: String, password: String) async throws -> AccessTokenEntity {

        do {
            let accessTokenEntity = try await APIClientManager.shared.generateAccessToken(email: email, password: password)
            KeychainAccessManager.shared.saveJsonAccessToken(accessTokenEntity.token)
            return accessTokenEntity
        } catch {
            // MEMO: 厳密にはエラーハンドリングが必要
            throw APIError.error(message: "認証処理に失敗しました。メールアドレスとパスワードのご確認をお願いします。")
        }
    }

    func getStoredToken() -> String? {
        KeychainAccessManager.shared.getAuthenticationHeader()
    }

    func validateToken(_ token: String) async throws -> Bool {
        do {
            let accessTokenEntity = try await APIClientManager.shared.verifyAccessToken()
            return !accessTokenEntity.token.isEmpty
        } catch {
            // MEMO: 厳密にはエラーハンドリングが必要
            throw APIError.error(message: "トークンの有効期限が失効しています。再度ログイン処理をお願いします。")
        }
    }
}
