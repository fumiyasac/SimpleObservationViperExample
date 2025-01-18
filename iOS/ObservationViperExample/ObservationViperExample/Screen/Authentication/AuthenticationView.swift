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
            VStack(alignment: .leading, spacing: 20) {
                Text("Eメールアドレス:")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.gray)
                TextField("Email:", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                Text("パスワード:")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.gray)
                SecureField("Password:", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                // もしエラーが発生した場合にはエラーメッセージを表示する
                if let errorMessage = presenter.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                // Loading状態の場合はIndicatorを表示し、そうでない時はログインボタンを表示する
                if presenter.isLoading {
                    ProgressView()
                } else {
                    HStack {
                        Spacer()
                        Button(action: {
                            presenter.login(email: email, password: password)
                        }, label: {
                            Text("ログイン")
                                .font(.body)
                                .foregroundColor(Color(uiColor: UIColor(code: "#f88c75")))
                                .background(.white)
                                .frame(width: 240.0, height: 48.0)
                                .cornerRadius(24.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24.0)
                                        .stroke(Color(uiColor: UIColor(code: "#f88c75")), lineWidth: 1.0)
                                )
                        })
                        Spacer()
                    }
                    .disabled(email.isEmpty || password.isEmpty)
                    .padding(.vertical, 8.0)
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
