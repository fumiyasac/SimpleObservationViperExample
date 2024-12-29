//
//  AppRouter.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/12/29.
//

import Foundation
import Observation

@Observable class AppRouter {

    // MARK: - Enum

    enum Route {
        case authenticate
        case article
    }

    // MARK: - Property

    var currentRoute: Route = .authenticate

    // MARK: - Function

    func navigateToArtcle() {
        currentRoute = .article
    }
}
