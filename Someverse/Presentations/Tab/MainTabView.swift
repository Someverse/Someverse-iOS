//
//  MainTabView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

enum MainTab: Int, CaseIterable {
  case matching
  case feed
  case chat
  case my
  
  var title: String {
    switch self {
    case .matching: return "매칭"
    case .feed: return "피드"
    case .chat: return "채팅"
    case .my: return "마이"
    }
  }
  
  var icon: String {
    switch self {
    case .matching: return "Heart"
    case .feed: return "Paper"
    case .chat: return "Chat"
    case .my: return "Profile"
    }
  }
}

struct MainTabView: View {
  @State private var selectedTab: MainTab = .matching
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(MainTab.allCases, id: \.self) { tab in
        tabContent(for: tab)
          .tabItem {
            Label(tab.title, image: tab.icon)
          }
          .tag(tab)
      }
    }
    .tint(.someversePrimary)
    .onAppear {
      configureTabBarAppearance()
    }
  }
  
  private func configureTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    
    let normalAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor(Color.someverseInactive)
    ]
    let selectedAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor(Color.someversePrimary)
    ]
    
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.someverseInactive)
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.someversePrimary)
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
  @ViewBuilder
  private func tabContent(for tab: MainTab) -> some View {
    switch tab {
    case .matching:
      MatchingView()
    case .feed:
      FeedView()
    case .chat:
      ChatView()
    case .my:
      MyView()
    }
  }
}

#Preview {
  MainTabView()
}
