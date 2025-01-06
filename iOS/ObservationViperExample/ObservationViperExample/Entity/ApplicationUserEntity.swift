//
//  ApplicationUserEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/22.
//

import Foundation

struct ApplicationUserEntity: Hashable, Decodable {

    // MARK: - Property

    private let uuid = UUID()

    let email: String
    let token: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case email
        case token
    }

    // MARK: - Initializer

    init(
        email: String,
        token: String
    ) {
        self.email = email
        self.token = token
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.email = try container.decode(String.self, forKey: .email)
        self.token = try container.decode(String.self, forKey: .token)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: ApplicationUserEntity, rhs: ApplicationUserEntity) -> Bool {
        return lhs.email == rhs.email
            && lhs.token == rhs.token
    }
}
