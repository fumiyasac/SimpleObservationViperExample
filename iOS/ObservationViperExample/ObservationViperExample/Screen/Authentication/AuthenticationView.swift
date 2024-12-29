//
//  AuthenticationView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import SwiftUI

struct AuthenticationView: View {

    // MARK: - Property

    @State private var email = ""
    @State private var password = ""

    // MARK: - Presenter

    private let presenter: AuthenticationPresenterProtocol

    // MARK: - Initializer

    init(presenter: AuthenticationPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Body

    var body: some View {
        // TODO: 本番のView要素を適用させる
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            //
//            if presenter.isLoading {
//                ProgressView()
//            } else {
//                Button("Login") {
//                    presenter.login(email: email, password: password)
//                }
//                .disabled(email.isEmpty || password.isEmpty)
//            }

            //
//            if let errorMessage = presenter.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//            }
        }
        .padding()
    }
}
