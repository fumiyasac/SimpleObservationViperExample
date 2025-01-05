//
//  CategoryRankingEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/11.
//

struct CategoryRankingEntity: Hashable, Decodable {

    // MARK: - Property
    
    let id: Int
    let name: String
    let rank: Int
    
    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case name
        case rank
    }

    // MARK: - Initializer

    init(
        id: Int,
        name: String,
        rank: Int
    ) {
        self.id = id
        self.name = name
        self.rank = rank
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.rank = try container.decode(Int.self, forKey: .rank)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CategoryRankingEntity, rhs: CategoryRankingEntity) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.rank == rhs.rank
    }
}
