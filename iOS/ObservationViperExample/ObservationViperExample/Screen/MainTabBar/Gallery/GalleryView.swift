//
//  GalleryView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import SwiftUI

struct GalleryView: View {

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
                VStack {
                    Text("GalleryView")
                }
            }
            .onFirstAppear {
                presenter.fetchGalleries()
            }
            // Navigation表示に関する設定
            .navigationTitle("🎨Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
