//
//  GuidanceView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/01.
//

import SwiftUI

struct GuidanceView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                VStack {
                    Text("GalleryView")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("🗒️Guidance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GuidanceView()
}
