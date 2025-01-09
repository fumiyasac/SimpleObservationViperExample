//
//  FeedInteractor.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/09.
//

import Foundation

final class FeedInteractor: FeedInteractorProtocol {

    // MARK: - Function

    func fetchPickupFeeds() async throws -> [PickupFeedEntity] {
        return try await APIClientManager.shared.getPickupFeeds()
    }
    
    func fetchCategoryRankings() async throws -> [CategoryRankingEntity] {
        return try await APIClientManager.shared.getCategoryFeeds()
    }
    
    func fetchInformationFeeds(page: Int) async throws -> InformationFeedPageEntity {
        return try await APIClientManager.shared.getInformationFeedPage(page)
    }
}
