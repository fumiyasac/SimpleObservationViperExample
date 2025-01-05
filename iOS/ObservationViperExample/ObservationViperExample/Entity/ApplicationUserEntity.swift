//
//  ApplicationUserEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/22.
//

struct ApplicationUserEntity {

    // MARK: - Property

    let email: String
    let token: String

    // MARK: - Initializer

    init(
        email: String,
        token: String
    ) {
        self.email = email
        self.token = token
    }
}
