//
//  CategoryRankingTagsView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/18.
//

import SwiftUI

struct CategoryRankingTagsView: View {

    // MARK: - Property

    private var categoryRankingEntities: [CategoryRankingEntity]

    // MARK: - Initializer

    init(categoryRankingEntities: [CategoryRankingEntity]) {
        self.categoryRankingEntities = categoryRankingEntities
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8.0) {
                ForEach(categoryRankingEntities, id: \.id) { categoryRankingEntity in
                    CategoryRankingView(categoryRankingEntity: categoryRankingEntity)
                }
            }
        }
        .padding(.horizontal, 16.0)
    }
}

#Preview {
    CategoryRankingTagsView(categoryRankingEntities: getCategoryRankings())
}

fileprivate func getCategoryRankings() -> [CategoryRankingEntity] {
    guard let path = Bundle.main.path(forResource: "category_feed", ofType: "json") else {
        fatalError()
    }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        fatalError()
    }
    guard let result = try? JSONDecoder().decode([CategoryRankingEntity].self, from: data) else {
        fatalError()
    }
    return result
}
