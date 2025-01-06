//
//  AccessTokenEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/22.
//

import Foundation

struct AccessTokenEntity: Hashable, Decodable {

    // MARK: - Property

    let token: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case token
    }

    // MARK: - Initializer

    init(token: String) {
        self.token = token
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.token = try container.decode(String.self, forKey: .token)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(token)
    }

    static func == (lhs: AccessTokenEntity, rhs: AccessTokenEntity) -> Bool {
        return lhs.token == rhs.token
    }
}
