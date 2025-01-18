//
//  PickupFeedCarouselView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/18.
//

import SwiftUI

struct PickupFeedCarouselView: View {

    // MARK: - Property

    private var pickupFeedEntities: [PickupFeedEntity]

    // MARK: - Initializer

    init(pickupFeedEntities: [PickupFeedEntity]) {
        self.pickupFeedEntities = pickupFeedEntities
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16.0) {
                ForEach(pickupFeedEntities, id: \.id) { pickupFeedEntity in
                    PickupFeedView(pickupFeedEntity: pickupFeedEntity)
                }
            }
        }
        .padding(.horizontal, 16.0)
    }
}

#Preview {
    PickupFeedCarouselView(pickupFeedEntities: getPickupFeedEntities())
}

fileprivate func getPickupFeedEntities() -> [PickupFeedEntity] {
    guard let path = Bundle.main.path(forResource: "pickup_feed", ofType: "json") else {
        fatalError()
    }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        fatalError()
    }
    guard let result = try? JSONDecoder().decode([PickupFeedEntity].self, from: data) else {
        fatalError()
    }
    return result
}
