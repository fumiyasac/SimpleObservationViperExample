//
//  InformationFeedView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/18.
//

import SwiftUI
import NukeUI

struct InformationFeedView: View {

    // MARK: - Property

    private var informationFeedEntity: InformationFeedEntity

    // MARK: - Initializer

    init(informationFeedEntity: InformationFeedEntity) {
        self.informationFeedEntity = informationFeedEntity
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            // 1. メインの情報表示部分
            HStack(spacing: 0.0) {
                // 1-(1). サムネイル用画像表示
                LazyImage(url: URL(string: informationFeedEntity.thumbnail)) { imageState in
                    if let image = imageState.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60.0, height: 45.0)
                            .cornerRadius(4.0)
                            .background(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(.secondary.opacity(0.5))
                            )
                    } else {
                        Color(uiColor: UIColor(code: "#dddddd"))
                    }
                }
                .frame(width: 60.0, height: 45.0)
                // 1-(2). 基本情報表示
                VStack(alignment: .leading) {
                    Text(informationFeedEntity.title)
                        .font(.body)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.bottom, 1.0)
                    Text(informationFeedEntity.catchCopy)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 16.0)
                // 1-(3). Spacer
                Spacer()
            }
            // 2. 概要テキストの情報表示部分
            HStack(spacing: 0.0) {
                Text(informationFeedEntity.summary)
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10.0)

            }
            .padding(.top, 8.0)
            // 3. 下側Divider
            Divider()
                .background(Color(uiColor: .lightGray))
        }
        .padding(.top, 4.0)
        .padding([.leading, .trailing], 16.0)
    }
}

#Preview {
    let informationFeedEntity = InformationFeedEntity(
        id: 1,
        title: "My Information Title No.1",
        catchCopy: "Sample articles",
        summary: "This is description about No.1. Thank you.",
        thumbnail: "https://observation-viper.s3.ap-northeast-1.amazonaws.com/feed_shop1.jpg"
    )
    InformationFeedView(informationFeedEntity: informationFeedEntity)
}
