//
//  FeedContract.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/09.
//

import Foundation

// MARK: - Protocol

protocol FeedPresenterProtocol {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var pickupFeeds: [PickupFeedEntity] { get }
    var categoryRankings: [CategoryRankingEntity] { get }
    var informationFeeds: [InformationFeedEntity] { get }
    func fetchInitialFeeds()
    func fetchNextInformationFeeds()
}

protocol FeedInteractorProtocol {
    func fetchPickupFeeds() async throws -> [PickupFeedEntity]
    func fetchCategoryRankings() async throws -> [CategoryRankingEntity]
    func fetchInformationFeeds(page: Int) async throws -> InformationFeedPageEntity
}
