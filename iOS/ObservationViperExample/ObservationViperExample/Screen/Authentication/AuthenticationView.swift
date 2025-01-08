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
        NavigationStack {
            // TODO: 本番のView要素を適用させる
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Loading状態の場合はIndicatorを表示し、そうでない時はログインボタンを表示する
                if presenter.isLoading {
                    ProgressView()
                } else {
                    Button("Login") {
                        presenter.login(email: email, password: password)
                    }
                    .disabled(email.isEmpty || password.isEmpty)
                }
                
                // もしエラーが発生した場合にはエラーメッセージを表示する
                if let errorMessage = presenter.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .onFirstAppear {
                // 初回表示時に1度だけ認証処理を実行する
                presenter.validateToken()
            }
            // Navigation表示に関する設定
            .navigationTitle("🔑Login")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
