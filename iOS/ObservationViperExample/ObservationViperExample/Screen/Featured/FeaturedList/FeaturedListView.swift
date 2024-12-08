//
//  FeaturedListView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import SwiftUI

struct FeaturedListView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("FeaturedListView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Featured")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    FeaturedListView()
}
