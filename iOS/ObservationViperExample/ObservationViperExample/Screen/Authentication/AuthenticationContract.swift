//
//  AuthenticationContract.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

// MARK: - Protocol

protocol AuthenticationPresenterProtocol {
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    func login(email: String, password: String)
    func checkAuthenticationStatus()
}

protocol AuthenticationInteractorProtocol {
    func login(email: String, password: String) async throws -> ApplicationUserEntity
    func getStoredToken() -> String?
    func validateToken(_ token: String) async throws -> Bool
}
