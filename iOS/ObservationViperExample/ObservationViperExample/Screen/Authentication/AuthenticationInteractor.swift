//
//  AuthenticationInteractor.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

final class AuthenticationInteractor: AuthenticationInteractorProtocol {

    // MARK: - Function

    func login(email: String, password: String) async throws -> ApplicationUserEntity {

        // TODO: 本番のAPI処理を適用させる
        try await Task.sleep(for: .seconds(1))
        guard email.contains("@"), !password.isEmpty else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }
        return ApplicationUserEntity(token: "dummy_token")
    }

    func getStoredToken() -> String? {
        // TODO: Tokenは「KeychainAccess」から取り出す
        return UserDefaults.standard.string(forKey: "userToken")
    }

    func validateToken(_ token: String) async throws -> Bool {
        // TODO: 本番のAPI処理を適用させる
        // API呼び出しをシミュレート＆トークンの有効性を確認する
        try await Task.sleep(for: .seconds(0.5))
        return true
    }
}
