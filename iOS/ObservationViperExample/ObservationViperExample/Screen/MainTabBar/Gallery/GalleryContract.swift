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
    var galleries: [GalleryPhotoEntity] { get }
    func fetchGalleries()
}

protocol GalleryInteractorProtocol {
    func fetchGalleries() async throws -> [GalleryPhotoEntity]
}
