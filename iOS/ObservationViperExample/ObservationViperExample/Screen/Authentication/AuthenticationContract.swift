//
//  AuthenticationContract.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

// MARK: - Protocol

protocol AuthenticationPresenterProtocol {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func login(email: String, password: String)
    func checkAuthenticationStatus()
}

protocol AuthenticationInteractorProtocol {
    func login(email: String, password: String) async throws -> AccessTokenEntity
    func getStoredToken() -> String?
    func validateToken(_ token: String) async throws -> Bool
}
