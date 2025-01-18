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

        // Loading状態にする
        _isLoading = true
        _errorMessage = nil

        // 入力されたEメール・パスワードで認証処理を実行する
        Task { @MainActor in
            do {
                let _ = try await interactor.login(email: email, password: password)
                router.navigateToMainTabBar()
            } catch {
                _errorMessage = """
                ログインに失敗しました。
                入力情報に誤りがないかをご確認ください。
                """
            }
        }

        // 処理が完了した後にはLoading状態を元に戻す
        _isLoading = false
    }

    func validateToken() {

        // Tokenがデバイス内に存在するかを確認する
        if let token = interactor.getStoredToken() {

            // Loading状態にする
            _isLoading = true

            // 格納されたJWTの認証状態確認を実施する
            Task { @MainActor in
                do {
                    let isValid = try await interactor.validateToken(token)
                    if isValid {
                        router.navigateToMainTabBar()
                    }
                } catch {
                    _errorMessage = """
                    セッションの有効期限が切れました。
                    再度ログイン処理をお願いします。
                    """
                }
            }

            // 処理が完了した後にはLoading状態を元に戻す
            _isLoading = false
        }
    }
}
