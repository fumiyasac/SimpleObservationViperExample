//
//  AuthenticationContract.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation

// MARK: - Protocol

protocol AuthenticationPresenterProtocol {
    func login(email: String, password: String)
}

protocol AuthenticationInteractorProtocol {
    func login(email: String, password: String) async throws -> ApplicationUserEntity
}
