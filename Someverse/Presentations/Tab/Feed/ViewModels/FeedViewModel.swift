//
//  FeedViewModel.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published private(set) var feeds: [Feed] = []
  @Published var currentFeedIndex: Int = 0
  @Published private(set) var isLoading = false
  @Published var error: Error?

  // MARK: - Computed Properties
  var isEmpty: Bool {
    feeds.isEmpty
  }

  var feedCount: Int {
    feeds.count
  }

  // MARK: - Initialization
  init() {
    loadMockData()
  }

  // MARK: - Public Methods
  func loadFeeds() async {
    isLoading = true
    defer { isLoading = false }

    // TODO: API 연동 시 실제 서비스 호출로 대체
    loadMockData()
  }

  func createFeed() {
    // TODO: 피드 작성 화면으로 이동
  }

  func reportFeed(_ feed: Feed) {
    // TODO: 신고 로직 구현
  }

  func refreshFeeds() async {
    await loadFeeds()
  }

  // MARK: - Private Methods
  private func loadMockData() {
    #if DEBUG
    feeds = Feed.mockData
    #endif
  }
}
