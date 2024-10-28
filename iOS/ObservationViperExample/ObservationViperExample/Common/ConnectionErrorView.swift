//
//  SwiftUIView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/10/28.
//

import SwiftUI

struct ConnectionErrorView: View {

    // MARK: - Typealias

    typealias TapButtonAction = () -> Void

    // MARK: - Property

    private var connectionErrorTitleFont: Font {
        return Font.custom("AvenirNext-Bold", size: 18)
    }

    private var connectionErrorTitleColor: Color {
        return Color.primary
    }

    private var connectionErrorButtonFont: Font {
        return Font.custom("AvenirNext-Bold", size: 16)
    }

    private var connectionErrorButtonColor: Color {
        return Color.orange
    }

    private var tapButtonAction: ConnectionErrorView.TapButtonAction

    // MARK: - Initializer

    init(tapButtonAction: @escaping ConnectionErrorView.TapButtonAction) {
        self.tapButtonAction = tapButtonAction
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0.0) {
            // 1. Spacer
            Spacer()
            // 2. コンテンツ表示部分
            VStack {
                // (1) エラータイトル表示
                Text("Error: 表示データ取得失敗")
                    .font(connectionErrorTitleFont)
                    .foregroundColor(connectionErrorTitleColor)
                // (2) リクエスト再実行ボタン表示
                HStack {
                    Spacer()
                    Button(action: tapButtonAction, label: {
                        // MEMO: 縁取りをした角丸ボタンのための装飾
                        Text("再読み込みを実行する")
                            .font(connectionErrorButtonFont)
                            .foregroundColor(connectionErrorButtonColor)
                            .background(.white)
                            .frame(width: 240.0, height: 48.0)
                            .cornerRadius(24.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24.0)
                                    .stroke(connectionErrorButtonColor, lineWidth: 1.0)
                            )
                    })
                    Spacer()
                }
                .padding(.vertical, 24.0)
            }
            // 3. Spacer
            Spacer()
        }
        .padding(.horizontal, 12.0)
    }
}

#Preview {
    ConnectionErrorView(tapButtonAction: {})
}
