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
                case .mainTabBar:
                    TabView {
                        FeedView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "newspaper.circle.fill")
                                    Text("Feed")
                                }
                            }
                            .tag(0)
                        GalleryView(
                            presenter: GalleryPresenter(
                                interactor: GalleryInteractor()
                            )
                        )
                        .tabItem {
                            VStack {
                                Image(systemName: "photo.circle.fill")
                                Text("Gallery")
                            }
                        }
                        .tag(1)
                        GuidanceView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "bubble.right.circle.fill")
                                    Text("Guidance")
                                }
                            }
                            .tag(2)
                    }
                    .accentColor(Color(uiColor: UIColor(code: "#f88c75")))
                }
            }
        }
    }
}
