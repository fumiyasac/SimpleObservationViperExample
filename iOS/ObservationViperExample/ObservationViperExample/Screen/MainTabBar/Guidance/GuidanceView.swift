//
//  GuidanceView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/01.
//

import SwiftUI
import ScalingHeaderScrollView

struct GuidanceView: View {

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            ScalingHeaderScrollView {
                ZStack {
                    Rectangle()
                        .fill(.black.opacity(0.15))
                    Image("guidance_top")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .frame(height: 320.0)
            } content: {
                VStack {
                    Text(
                        """
                        guidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_topguidance_top
                        """
                    )
                }
                .padding(16.0)
            }
            .height(min: 0.0, max: 320.0)
            .allowsHeaderCollapse()
            .allowsHeaderGrowth(true)
            .ignoresSafeArea(edges: [.top])
            // Navigation表示に関する設定
            .navigationTitle("🗒️Guidance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GuidanceView()
}
