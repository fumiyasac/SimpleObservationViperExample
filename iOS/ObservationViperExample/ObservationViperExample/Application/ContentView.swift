//
//  ContentView.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/10/19.
//

import SwiftUI

struct ContentView: View {

    // MEMO: 対応する画面はVIPERに対応する形にする

    // MARK: - Body

    var body: some View {
        ZStack {
            TabView {
                // CourseListコンテンツ画面
                CourseListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "pencil.tip.crop.circle.fill")
                            Text("Course")
                        }
                    }
                    .tag(0)
                // FeaturedListコンテンツ画面
                FeaturedListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet.circle.fill")
                            Text("Featured")
                        }
                    }
                    .tag(1)
                // ArticleListコンテンツ画面
                ArticleListView()
                    .tabItem {
                        VStack {
                            Image(systemName: "doc.text.fill")
                            Text("Article")
                        }
                    }.tag(2)
            }
            .accentColor(Color(uiColor: UIColor(code: "#f88c75")))
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
