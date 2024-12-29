//
//  AuthenticationPresenter.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

@Observable
final class AuthenticationPresenter: AuthenticationPresenterProtocol {

    private let interactor: AuthenticationInteractorProtocol
    private let router: AppRouter
    
    var isLoading = false
    var errorMessage: String?

    init(interactor: AuthenticationInteractorProtocol, router: AppRouter) {
        self.interactor = interactor
        self.router = router
    }

    func login(email: String, password: String) {
        Task { @MainActor in

            isLoading = true
            errorMessage = nil

            do {
                let user = try await interactor.login(email: email, password: password)
                UserDefaults.standard.set(user.token, forKey: "userToken")
                router.navigateToArtcle()
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}
