//
//  LoginView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/20.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("LoginView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
