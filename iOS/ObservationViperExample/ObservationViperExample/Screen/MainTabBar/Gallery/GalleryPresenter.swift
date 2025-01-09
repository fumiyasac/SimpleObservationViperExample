//
//  GalleryPresenter.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/07.
//

import Foundation
import Observation

@Observable
final class GalleryPresenter: GalleryPresenterProtocol {

    // MARK: - Property (Dependency)

    private let interactor: GalleryInteractorProtocol

    // MARK: - Property (Computed)

    private var _isLoading: Bool = false
    private var _errorMessage: String?
    private var _galleryPhotos: [GalleryPhotoEntity] = []

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }

    var galleryPhotos: [GalleryPhotoEntity] {
        _galleryPhotos
    }

    // MARK: - Initializer

    init(interactor: GalleryInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - Function

    func fetchGalleryPhotos() {

        // Loading状態にする
        _isLoading = true

        Task { @MainActor in
            do {
                _galleryPhotos = try await interactor.fetchGalleryPhotos()

            } catch {
                _errorMessage = """
                Gallery情報の取得に失敗しました。
                """
            }
        }
        
        // 処理が完了した後にはLoading状態を元に戻す
        _isLoading = false
    }
}
