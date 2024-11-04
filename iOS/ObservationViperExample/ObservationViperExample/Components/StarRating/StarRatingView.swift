//
//  StarRatingView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/04.
//

import SwiftUI

struct StarRatingView: View {

    // MARK: - Property

    @State private var rating: Double = 0.0

    // MARK: - Initializer

    init(rating: Double) {
        // イニシャライザ内で「_(変数名)」値を代入することでState値の初期化を実行する
        _rating = State(initialValue: rating)
    }

    // MARK: - Body

    public var body: some View {
        // MEMO: ライブラリ「Cosmos」のView要素にイニシャライザで受け取った値を反映する
        RatingViewRepresentable(rating: $rating)
    }
}
