//
//  GalleryView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/03.
//

import NukeUI
import SwiftUI

// (参考1) Matched Geometry Effectの基本
// https://develop.designcode.io/swiftui-handbook-matched-geometry-effect
// (参考2) こちらのライブコーディング動画を参考に実装しました。
// https://www.youtube.com/watch?v=89fps_fP9DM
// https://www.youtube.com/watch?v=93SeJ9ousBw

struct GalleryView: View {
    
    // MARK: - Property
    
    @State private var selectedGalleryPhotoEntity: GalleryPhotoEntity?
    @State private var position = CGSize.zero
    @Namespace private var namespace
    
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
                        showGridPhotoGalleryView()
                        showWhiteBackgroundView()
                        showExpandedImageViewIfNeeded()
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
    
    @ViewBuilder
    private func showGridPhotoGalleryView() -> some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 1.0) {
                ForEach(presenter.galleryPhotos, id: \.id) { galleryPhotoEntity in
                    LazyImage(url: URL(string: galleryPhotoEntity.thumbnail)) { imageState in
                        if let image = imageState.image {
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)

                        } else {
                            Color(.white)
                        }
                    }
                    .matchedGeometryEffect(
                        id: "gallery_\(galleryPhotoEntity.id)",
                        in: namespace
                    )
                    .onTapGesture {
                        position = .zero
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            selectedGalleryPhotoEntity = galleryPhotoEntity
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func showWhiteBackgroundView() -> some View {
        Color.white
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .opacity(selectedGalleryPhotoEntity == nil ? 0 : min(1, max(0, 1 - abs(Double(position.height) / 1200))))
    }
    
    @ViewBuilder
    private func showExpandedImageViewIfNeeded() -> some View {
        if let targetSelectedGalleryPhotoEntity = selectedGalleryPhotoEntity {
            LazyImage(url: URL(string: targetSelectedGalleryPhotoEntity.thumbnail)) { imageState in
                if let image = imageState.image {
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .matchedGeometryEffect(
                            id: "gallery_\(targetSelectedGalleryPhotoEntity.id)",
                            in: namespace
                        )
                } else {
                    Color(.white)
                }
            }
            .zIndex(99)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.48)) {
                    selectedGalleryPhotoEntity = nil
                }
            }
            .offset(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.translation
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut(duration: 0.48)) {
                            if 200.0 < abs(position.height) {
                                selectedGalleryPhotoEntity = nil
                            } else {
                                position = .zero
                            }
                        }
                    })
        }
    }
}
