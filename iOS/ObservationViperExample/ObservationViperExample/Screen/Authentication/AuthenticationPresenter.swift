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

    // MARK: - Property (Computed)

    private var _isLoading: Bool = false
    private var _errorMessage: String?

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }

    // MARK: - Initializer

    init(interactor: AuthenticationInteractorProtocol, router: AppRouter) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Function

    func login(email: String, password: String) {
        Task { @MainActor in

            // Loading状態
            _isLoading = true
            _errorMessage = nil

            // 認証処理
            do {
                let user = try await interactor.login(email: email, password: password)
                // TODO: Tokenは「KeychainAccess」を利用して保持する
                UserDefaults.standard.set(user.token, forKey: "userToken")
                router.navigateToArtcle()
            } catch {
                _errorMessage = """
                ログインに失敗しました。
                入力情報に誤りがないかをご確認ください。
                """
            }

            // 処理完了
            _isLoading = false
        }
    }

    func checkAuthenticationStatus() {
        Task { @MainActor in
            
            // Tokenがデバイス内に存在するかを確認
            if let token = interactor.getStoredToken() {

                // Loading状態
                _isLoading = true

                // 認証処理
                do {
                    // トークンの有効性を確認
                    // TODO: 実際はAPIリクエストを利用して有用性を確認する
                    let isValid = try await interactor.validateToken(token)
                    if isValid {
                        router.navigateToArtcle()
                    }
                } catch {
                    _errorMessage = """
                    セッションの有効期限が切れました。
                    再度ログイン処理をお願いします。
                    """
                }

                // 処理完了
                _isLoading = false
            }
        }
    }
}
