//
//  GalleryPhotoEntity.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/11.
//

struct GalleryPhotoEntity: Hashable, Decodable {

    // MARK: - Property
    
    let id: Int
    let title: String
    let thumbnail: String
    
    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case title
        case thumbnail
    }

    // MARK: - Initializer

    init(
        id: Int,
        title: String,
        thumbnail: String
    ) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: GalleryPhotoEntity, rhs: GalleryPhotoEntity) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.thumbnail == rhs.thumbnail
    }
}
