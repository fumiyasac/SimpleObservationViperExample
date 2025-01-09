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
                VStack {
                    Text("FeedView")
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
