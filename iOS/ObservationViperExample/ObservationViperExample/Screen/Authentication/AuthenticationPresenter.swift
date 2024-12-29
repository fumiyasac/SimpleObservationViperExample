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

    // MARK: - Property (Dependency `@Observable`)

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
                UserDefaults.standard.set(user.token, forKey: "userToken")
                router.navigateToArtcle()
            } catch {
                errorMessage = error.localizedDescription
            }

            // 処理完了
            isLoading = false
        }
    }
}
