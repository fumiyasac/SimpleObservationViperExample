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
                VStack(alignment: .leading, spacing: 0.0) {
                    Group {
                        Text("こちらはアプリの使い方や応用的に活用する便利な方法を紹介するページです。お店の情報やストーリー等と共に様々なレストラン情報やお得な割引クーポン等を紹介していますので、是非使い倒して下さい。")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding(.bottom, 12.0)
                        Text("Capter1:")
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.gray)
                            .padding(.bottom, 8.0)
                        Text("（サンプル文章）こちらにはサンプルテキストが入ります。料理や食材に関する料理人のアピールポイントやこだわり、お店の特徴や口コミ等も掲載していますので、読み物としてだけではなく、お食事時に便利なクーポン情報の管理にも利用する事ができます。")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding(.bottom, 12.0)
                        Image("guidance_side1")
                            .resizable()
                            .scaledToFill()
                            .padding(.bottom, 12.0)
                        Text("Capter2:")
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.gray)
                            .padding(.bottom, 8.0)
                        Text("（サンプル文章）こちらにはサンプルテキストが入ります。料理や食材に関する料理人のアピールポイントやこだわり、お店の特徴や口コミ等も掲載していますので、読み物としてだけではなく、お食事時に便利なクーポン情報の管理にも利用する事ができます。")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding(.bottom, 12.0)
                        Image("guidance_side2")
                            .resizable()
                            .scaledToFill()
                            .padding(.bottom, 12.0)
                        Text("Capter3:")
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.gray)
                            .padding(.bottom, 8.0)
                        Text("（サンプル文章）こちらにはサンプルテキストが入ります。料理や食材に関する料理人のアピールポイントやこだわり、お店の特徴や口コミ等も掲載していますので、読み物としてだけではなく、お食事時に便利なクーポン情報の管理にも利用する事ができます。")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding(.bottom, 12.0)
                        Image("guidance_side3")
                            .resizable()
                            .scaledToFill()
                            .padding(.bottom, 12.0)
                        Text("Capter4:")
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.gray)
                            .padding(.bottom, 8.0)
                        Text("（サンプル文章）こちらにはサンプルテキストが入ります。料理や食材に関する料理人のアピールポイントやこだわり、お店の特徴や口コミ等も掲載していますので、読み物としてだけではなく、お食事時に便利なクーポン情報の管理にも利用する事ができます。")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding(.bottom, 12.0)
                        Image("guidance_side4")
                            .resizable()
                            .scaledToFill()
                            .padding(.bottom, 12.0)
                    }
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
