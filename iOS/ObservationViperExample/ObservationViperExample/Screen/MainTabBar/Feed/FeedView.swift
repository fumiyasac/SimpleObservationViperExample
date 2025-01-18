//
//  FeedView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/30.
//

import SwiftUI

struct FeedView: View {

    // MARK: - Presenter

    private let presenter: FeedPresenterProtocol

    // MARK: - Initializer

    init(presenter: FeedPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Body

    var body: some View {
        // MEMO: UIKitのNavigationController表示を実施する
        NavigationStack {
            Group {
                switch (presenter.isLoading, presenter.errorMessage) {
                case (true, _):
                    // Loading Indicatorを表示する
                    ExecutingConnectionView()
                case (_, presenter.errorMessage) where presenter.errorMessage != nil:
                    // Error Message画面を表示する
                    ConnectionErrorView(
                        tapButtonAction: {
                            presenter.fetchInitialFeeds()
                        }
                    )
                default:
                    // ScrollViewを利用したCarousel表示やPagination処理をするView要素を配置する
                    ScrollView {
                        PickupFeedCarouselView(pickupFeedEntities: presenter.pickupFeeds)
                            .padding(.top, 16.0)
                        CategoryRankingTagsView(categoryRankingEntities: presenter.categoryRankings)
                            .padding(.top, 8.0)
                            .padding(.bottom, 4.0)
                        LazyVStack {
                            ForEach(presenter.informationFeeds, id: \.id) { informationFeedEntity in
                                InformationFeedView(informationFeedEntity: informationFeedEntity)
                                    .onAppear {
                                        if informationFeedEntity.id == presenter.informationFeeds.count {
                                            presenter.fetchNextInformationFeeds()
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .onFirstAppear {
                presenter.fetchInitialFeeds()
            }
            // Navigation表示に関する設定
            .navigationTitle("🗞️FeedView")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
