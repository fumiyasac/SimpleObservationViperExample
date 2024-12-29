//
//  AuthenticationPresenter.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation
import Observation

@Observable
final class AuthenticationPresenter: AuthenticationPresenterProtocol {

    // MARK: - Property (Dependency)

    private let interactor: AuthenticationInteractorProtocol
    private let router: AppRouter

    // MARK: - Property (`@Observable`)

    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Initializer

    init(interactor: AuthenticationInteractorProtocol, router: AppRouter) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Function

    func login(email: String, password: String) {
        Task { @MainActor in

            // Loading状態
            isLoading = true
            errorMessage = nil

            // 認証処理
            do {
                let user = try await interactor.login(email: email, password: password)
                // TODO: Tokenは「KeychainAccess」を利用して保持する
                UserDefaults.standard.set(user.token, forKey: "userToken")
                router.navigateToArtcle()
            } catch {
                errorMessage = error.localizedDescription
            }

            // 処理完了
            isLoading = false
        }
    }

    func checkAuthenticationStatus() {
        Task { @MainActor in
            
            // Tokenがデバイス内に存在するかを確認
            if let token = interactor.getStoredToken() {

                // Loading状態
                isLoading = true

                // 認証処理
                do {
                    // トークンの有効性を確認
                    // TODO: 実際はAPIリクエストを利用して有用性を確認する
                    let isValid = try await interactor.validateToken(token)
                    if isValid {
                        router.navigateToArtcle()
                    }
                } catch {
                    errorMessage = "Session expired. Please login again."
                }

                // 処理完了
                isLoading = false
            }
        }
    }
}
