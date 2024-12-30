//
//  FeedView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/30.
//

import SwiftUI

struct FeedView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("FeedView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("🗞️FeedView")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
