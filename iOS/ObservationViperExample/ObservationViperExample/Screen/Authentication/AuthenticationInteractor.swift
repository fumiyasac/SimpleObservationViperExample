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
        return ApplicationUserEntity(email: email, token: "dummy_token")
    }
}
