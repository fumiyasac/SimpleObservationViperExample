//
//  ObservationViperExampleApp.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/10/19.
//

import SwiftUI

@main
struct ObservationViperExampleApp: App {

    // MARK: - Property

    // MEMO: AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // Router定義をここで設定する
    @State private var router = AppRouter()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            Group {
                switch router.currentRoute {
                case .authenticate:
                    AuthenticationView(
                        presenter: AuthenticationPresenter(
                            interactor: AuthenticationInteractor(),
                            router: router
                        )
                    )
                case .gallery:
                    GalleryView()
                }
            }
        }
    }
}
