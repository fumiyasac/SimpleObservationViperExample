//
//  PickupFeedEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/05.
//

struct PickupFeedEntity: Hashable, Decodable {

    // MARK: - Property
    
    let id: Int
    let shopName: String
    let categoryName: String
    let minBudget: String
    let rating: Double
    let thumbnail: String
    
    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case shopName = "shop_name"
        case categoryName = "category_name"
        case minBudget = "min_budget"
        case rating
        case thumbnail
    }

    // MARK: - Initializer

    init(
        id: Int,
        shopName: String,
        categoryName: String,
        minBudget: String,
        rating: Double,
        thumbnail: String
    ) {
        self.id = id
        self.shopName = shopName
        self.categoryName = categoryName
        self.minBudget = minBudget
        self.rating = rating
        self.thumbnail = thumbnail
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.shopName = try container.decode(String.self, forKey: .shopName)
        self.categoryName = try container.decode(String.self, forKey: .categoryName)
        self.minBudget = try container.decode(String.self, forKey: .minBudget)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PickupFeedEntity, rhs: PickupFeedEntity) -> Bool {
        return lhs.id == rhs.id
            && lhs.shopName == rhs.shopName
            && lhs.categoryName == rhs.categoryName
            && lhs.minBudget == rhs.minBudget
            && lhs.rating == rhs.rating
            && lhs.thumbnail == rhs.thumbnail
    }
}
