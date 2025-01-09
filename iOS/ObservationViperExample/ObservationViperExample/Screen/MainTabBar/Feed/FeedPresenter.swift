//
//  FeedPresenter.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/09.
//

import Foundation
import Observation

@Observable
final class FeedPresenter: FeedPresenterProtocol {

    // MARK: - Property (Dependency)

    private let interactor: FeedInteractorProtocol

    // MARK: - Property (Computed)

    private var _isLoading: Bool = false
    private var _errorMessage: String?
    private var _pickupFeeds: [PickupFeedEntity] = []
    private var _categoryRankings: [CategoryRankingEntity] = []
    private var _informationFeeds: [InformationFeedEntity] = []

    @ObservationIgnored
    private var _page: Int = 1

    @ObservationIgnored
    private var _hasNextPage: Bool = true

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }

    var pickupFeeds: [PickupFeedEntity] {
        _pickupFeeds
    }

    var categoryRankings: [CategoryRankingEntity] {
        _categoryRankings
    }

    var informationFeeds: [InformationFeedEntity] {
        _informationFeeds
    }

    // MARK: - Initializer

    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }

    func fetchInitialFeeds() {
        // Loading状態にする
        _isLoading = true

        Task { @MainActor in
            do {
                async let pickupFeeds = try await interactor.fetchPickupFeeds()
                async let categoryRankings = try await interactor.fetchCategoryRankings()
                async let informationPerPage = try await interactor.fetchInformationFeeds(page: 1)

                _pickupFeeds = try await pickupFeeds
                _categoryRankings = try await categoryRankings
                _informationFeeds = try await informationPerPage.infomation
                _page += 1

            } catch {
                _errorMessage = """
                初回情報の取得に失敗しました。
                """
            }
        }
        
        // 処理が完了した後にはLoading状態を元に戻す
        _isLoading = false
    }

    func fetchNextInformationFeeds() {

        guard !_hasNextPage else {
            return
        }

        // Loading状態にする
        _isLoading = true

        Task { @MainActor in
            do {
                let informationPerPage = try await interactor.fetchInformationFeeds(page: _page)
                _informationFeeds += informationPerPage.infomation
                _page += 1

            } catch {
                _errorMessage = """
                InformationFeed情報の取得に失敗しました。
                """
            }
        }
        
        // 処理が完了した後にはLoading状態を元に戻す
        _isLoading = false
    }
}
