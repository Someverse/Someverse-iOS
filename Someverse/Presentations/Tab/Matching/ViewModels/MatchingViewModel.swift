//
//  MatchingViewModel.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI
import Combine

@MainActor
final class MatchingViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published private(set) var matchingProfiles: [MatchingProfile] = []
  @Published private(set) var isLoading = false
  @Published var error: Error?

  // MARK: - Constants
  let maxDisplayCount = 2

  // MARK: - Computed Properties
  var displayProfiles: [MatchingProfile] {
    Array(matchingProfiles.prefix(maxDisplayCount))
  }

  var isEmpty: Bool {
    matchingProfiles.isEmpty
  }

  // MARK: - Initialization
  init() {
    loadMockData()
  }

  // MARK: - Public Methods
  func loadProfiles() async {
    isLoading = true
    defer { isLoading = false }

    // TODO: API 연동 시 실제 서비스 호출로 대체
    // do {
    //   matchingProfiles = try await matchingService.fetchProfiles()
    // } catch {
    //   self.error = error
    // }

    loadMockData()
  }

  func reportProfile(_ profile: MatchingProfile) {
    // TODO: 신고 로직 구현
  }

  func refreshProfiles() async {
    await loadProfiles()
  }

  // MARK: - Private Methods
  private func loadMockData() {
    #if DEBUG
    matchingProfiles = MatchingProfile.mockData
    #endif
  }
}
