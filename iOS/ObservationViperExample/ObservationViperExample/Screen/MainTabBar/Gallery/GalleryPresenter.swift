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
    private var _galleries: [GalleryPhotoEntity] = []

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }

    var galleries: [GalleryPhotoEntity] {
        _galleries
    }

    // MARK: - Initializer

    init(interactor: GalleryInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - Function

    func fetchGalleries() async throws {

        // Loading状態にする
        _isLoading = true

        Task { @MainActor in
            do {
                _galleries = try await interactor.fetchGalleries()

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
