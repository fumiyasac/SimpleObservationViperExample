//
//  CourseListView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import SwiftUI

// MEMO: CourseのBookMark一覧は遷移先で展開する

struct CourseListView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("CourseListView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Course")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    CourseListView()
}
