//
//  MatchingModels.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import Foundation

struct MatchingProfile: Identifiable, Equatable, Codable {
  let id: UUID
  let imageURL: URL?
  let nickname: String
  let age: Int
  let locations: [String]
  let genres: [String]

  init(
    id: UUID = UUID(),
    imageURL: URL? = nil,
    nickname: String,
    age: Int,
    locations: [String],
    genres: [String]
  ) {
    self.id = id
    self.imageURL = imageURL
    self.nickname = nickname
    self.age = age
    self.locations = locations
    self.genres = genres
  }
}

// MARK: - Mock Data
#if DEBUG
extension MatchingProfile {
  static let mockData: [MatchingProfile] = [
    MatchingProfile(
      nickname: "마포구보안관2",
      age: 28,
      locations: ["서울특별시 성북구", "경기도 화성시"],
      genres: ["뮤지컬", "스릴러/범죄", "드라마", "코미디"]
    ),
    MatchingProfile(
      nickname: "굿데이",
      age: 29,
      locations: ["서울특별시 관악구", "경기도 화성시"],
      genres: ["뮤지컬", "스릴러/범죄", "드라마", "코미디"]
    )
  ]
}
#endif
