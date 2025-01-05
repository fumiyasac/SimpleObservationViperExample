//
//  InformationFeedPageEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/05.
//

import Foundation

struct InformationFeedPageEntity: Hashable, Decodable {

    // MARK: - Property

    private let uuid = UUID()

    let page: Int
    let hasNextPage: Bool
    let infomation: [InformationFeedEntity]
    
    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case page
        case hasNextPage = "has_next_page"
        case infomation
    }

    // MARK: - Initializer

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.page = try container.decode(Int.self, forKey: .page)
        self.hasNextPage = try container.decode(Bool.self, forKey: .hasNextPage)
        self.infomation = try container.decode([InformationFeedEntity].self, forKey: .infomation)
    }
    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: InformationFeedPageEntity, rhs: InformationFeedPageEntity) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
