//
//  BookmarkListView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import SwiftUI

struct BookmarkListView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("BookmarkListView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Bookmark")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    BookmarkListView()
}
