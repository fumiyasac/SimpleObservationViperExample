//
//  PickupFeedView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/18.
//

import SwiftUI
import NukeUI

struct PickupFeedView: View {

    // MARK: - Property

    private var pickupFeedEntity: PickupFeedEntity

    // MARK: - Initializer

    init(pickupFeedEntity: PickupFeedEntity) {
        self.pickupFeedEntity = pickupFeedEntity
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                LazyImage(url: URL(string: pickupFeedEntity.thumbnail)) { imageState in
                    if let image = imageState.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 240.0, height: 320.0)
                            .cornerRadius(8.0)
                    } else {
                        Color(uiColor: UIColor(code: "#dddddd"))
                    }
                }
                .frame(width: 240.0, height: 320.0)
                Rectangle()
                    .foregroundColor(.black.opacity(0.36))
                    .frame(width: 240.0, height: 320.0)
                    .cornerRadius(8.0)
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(pickupFeedEntity.shopName)
                                .font(.body)
                                .bold()
                                .foregroundColor(.white)
                                .lineLimit(3)
                                .padding([.top, .leading], 16.0)
                                .padding(.trailing, 6.0)
                            Text("💴 予算: \(pickupFeedEntity.minBudget)円")
                                .font(.callout)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.top, 1.0)
                                .padding(.leading, 16.0)
                                .padding(.trailing, 6.0)
                            Text("🍽️ カテゴリー: \(pickupFeedEntity.categoryName)")
                                .font(.callout)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.top, 1.0)
                                .padding(.leading, 16.0)
                                .padding(.trailing, 6.0)
                        }
                        Spacer()
                    }
                    Spacer()
                    // MEMO: 星形レーティング表示部分はRatingViewRepresentableと橋渡しをするStarRatingViewを経由して表示する
                    // 👉 RatingViewRepresentable.swiftでUIKit製のライブラリで提供している「Cosmos」を利用できる様にしています。
                    StarRatingView(rating: pickupFeedEntity.rating)
                    HStack {
                        Text("点数:")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .padding(.bottom, 8.0)
                        Text(String(format: "%.1f", pickupFeedEntity.rating))
                            .font(.title)
                            .bold()
                            .foregroundColor(.red)
                            .lineLimit(1)
                            .padding(.bottom, 8.0)
                    }
                    .padding(.bottom, 4.0)

                }
                .frame(width: 240.0, height: 320.0)
            }
        }
    }
}

#Preview {
    let pickupFeedEntity = PickupFeedEntity(
        id: 1,
        shopName: "Pickup Sample No.1",
        categoryName: "寿司",
        minBudget: "16,000",
        rating: 3.8,
        thumbnail: "https://observation-viper.s3.ap-northeast-1.amazonaws.com/feed_pickup1.jpg"
    )
    PickupFeedView(pickupFeedEntity: pickupFeedEntity)
}
