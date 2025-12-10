//
//  MyViewModel.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI
import Combine

@MainActor
final class MyViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published private(set) var profile: MyProfile?
  @Published private(set) var myFeeds: [MyFeed] = []
  @Published private(set) var curation: TasteCuration?
  @Published private(set) var tasteTheme: TasteTheme?
  @Published private(set) var hasTasteTheme: Bool = false
  @Published private(set) var isLoading = false
  @Published var error: Error?

  // MARK: - Computed Properties
  var hasFeeds: Bool {
    !myFeeds.isEmpty
  }

  var displayFeeds: [MyFeed] {
    Array(myFeeds.prefix(3))
  }

  var favoriteGenres: [String] {
    curation?.favoriteGenres ?? []
  }

  var favoriteWorks: [URL] {
    curation?.favoriteWorks ?? []
  }

  // MARK: - Initialization
  init() {
    loadMockData()
  }

  // MARK: - Public Methods
  func loadProfile() async {
    isLoading = true
    defer { isLoading = false }

    // TODO: API 연동 시 실제 서비스 호출로 대체
    loadMockData()
  }

  func editProfile() {
    // TODO: 프로필 편집 화면으로 이동
  }

  func createFeed() {
    // TODO: 피드 작성 화면으로 이동
  }

  func viewMoreFeeds() {
    // TODO: 피드 더보기 화면으로 이동
  }

  func editGenres() {
    // TODO: 장르 편집 화면으로 이동
  }

  func editFavoriteWorks() {
    // TODO: 좋아하는 작품 편집 화면으로 이동
  }

  func editTasteTheme() {
    // TODO: 취향 테마 편집 화면으로 이동
  }

  func viewPoints() {
    // TODO: 포인트 화면으로 이동
  }

  func viewSettings() {
    // TODO: 설정 화면으로 이동
  }

  func refreshProfile() async {
    await loadProfile()
  }

  // MARK: - Private Methods
  private func loadMockData() {
    #if DEBUG
    profile = MyProfile(
      imageURL: nil,
      nickname: "드라마메이커",
      age: 24,
      regions: ["성북구", "관악구"]
    )

    curation = TasteCuration(
      favoriteGenres: ["뮤지컬", "공포/호러", "SF", "애니메이션"],
      favoriteWorks: []
    )

    tasteTheme = TasteTheme(
      moods: ["웅장한", "신나는", "희망적인"],
      narratives: ["첫사랑", "성장", "디스토피아"],
      duckPoints: ["명대사", "OST", "굿즈"],
      discussionTopics: ["결말해석", "왓이프", "종교", "망작까기"]
    )

    myFeeds = MyFeed.mockData
    hasTasteTheme = tasteTheme != nil
    #endif
  }
}
