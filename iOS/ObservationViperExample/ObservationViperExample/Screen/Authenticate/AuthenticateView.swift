//
//  AuthenticateView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import SwiftUI

struct AuthenticateView: View {

    // MARK: - Property

    @State private var email = ""
    @State private var password = ""

    // MARK: - Presenter

    private var presenter: AuthenticatePresenterProtocol

    // MARK: - Initializer

    init(presenter: AuthenticatePresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Body

    var body: some View {
        // TODO: 本番のView要素を適用させる
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Login") {
                presenter.login(email: email, password: password)
            }
        }
    }
}
