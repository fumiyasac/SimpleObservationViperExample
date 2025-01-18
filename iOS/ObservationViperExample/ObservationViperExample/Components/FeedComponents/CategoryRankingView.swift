//
//  CategoryFeedView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/18.
//

import SwiftUI

struct CategoryRankingView: View {

    // MARK: - Property

    private var categoryRankingEntity: CategoryRankingEntity

    // MARK: - Initializer

    init(categoryRankingEntity: CategoryRankingEntity) {
        self.categoryRankingEntity = categoryRankingEntity
    }

    // MARK: - Body

    var body: some View {
        let medalMark = getMedalMark(categoryRankingEntity: categoryRankingEntity)
        VStack(alignment: .leading) {
            Text("\(medalMark)\(categoryRankingEntity.name)")
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal, 12.0)
                .padding(.vertical, 6.0)
        }
        .background(Color(uiColor: UIColor(code: "#f88c75")))
        // MEMO: 角丸にしたい場合には.cornerRadiusと.overlayを両方設定する必要がある
        .cornerRadius(24.0)
        .overlay(
            RoundedRectangle(cornerRadius: 24.0)
                .stroke(Color(uiColor: UIColor(code: "#f88c75")), lineWidth: 1.0)
        )
    }
    
    // MARK: - Private Function

    private func getMedalMark(categoryRankingEntity: CategoryRankingEntity) -> String {
        switch(categoryRankingEntity.rank) {
        case 1:
            return "🥇"
        case 2:
            return "🥈"
        case 3:
            return "🥉"
        default:
            return ""
        }
    }
}

#Preview {
    CategoryRankingView(
        categoryRankingEntity: CategoryRankingEntity(
            id: 1, name: "和食", rank: 1
        )
    )
}
