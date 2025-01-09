//
//  GalleryContract.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2025/01/07.
//

import Foundation

// MARK: - Protocol

protocol GalleryPresenterProtocol {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var galleryPhotos: [GalleryPhotoEntity] { get }
    func fetchGalleryPhotos()
}

protocol GalleryInteractorProtocol {
    func fetchGalleryPhotos() async throws -> [GalleryPhotoEntity]
}
