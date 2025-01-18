//
//  GalleryView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import NukeUI
import SwiftUI

struct GalleryView: View {

    // MARK: - Property
 
    private var gridColumns: [GridItem] {
        (0..<3).map { _ in GridItem(.flexible(minimum: 100, maximum: 200), spacing: 1) }
    }

    // MARK: - Presenter

    private let presenter: GalleryPresenterProtocol

    // MARK: - Initializer

    init(presenter: GalleryPresenterProtocol) {
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
                            presenter.fetchGalleryPhotos()
                        }
                    )
                default:
                    // Grid表示を伴うGallery画面を表示する
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: gridColumns, spacing: 1.0) {
                                ForEach(presenter.galleryPhotos, id: \.id) { galleryPhoto in
                                    LazyImage(url: URL(string: galleryPhoto.thumbnail)) { imageState in
                                        if let image = imageState.image {
                                            image
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fill)
                                        } else {
                                            Color(uiColor: UIColor(code: "#dddddd"))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onFirstAppear {
                presenter.fetchGalleryPhotos()
            }
            // Navigation表示に関する設定
            .navigationTitle("🎨Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
