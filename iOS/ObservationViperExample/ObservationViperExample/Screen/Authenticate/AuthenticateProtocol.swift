//
//  AuthenticateProtocol.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

// MARK: - Protocol

protocol AuthenticatePresenterProtocol {
    func login(email: String, password: String)
}

protocol AuthenticateInteractorProtocol {
    func login(email: String, password: String) async throws -> ApplicationUserEntity
}
