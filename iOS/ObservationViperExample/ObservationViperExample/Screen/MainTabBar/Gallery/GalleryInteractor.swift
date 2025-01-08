//
//  GalleryInteractor.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/07.
//

import Foundation

final class GalleryInteractor: GalleryInteractorProtocol {

    // MARK: - Function

    func fetchGalleries() async throws -> [GalleryPhotoEntity] {
        return try await APIClientManager.shared.getGalleries()
    }
}
