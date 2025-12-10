//
//  MyModels.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import Foundation

struct MyProfile: Equatable, Codable {
  let imageURL: URL?
  let nickname: String
  let age: Int
  let regions: [String]
}

struct MyFeed: Identifiable, Equatable, Codable {
  let id: UUID
  let movieTitle: String
  let year: String
  let comment: String
  let imageURL: URL?

  init(
    id: UUID = UUID(),
    movieTitle: String,
    year: String,
    comment: String,
    imageURL: URL? = nil
  ) {
    self.id = id
    self.movieTitle = movieTitle
    self.year = year
    self.comment = comment
    self.imageURL = imageURL
  }
}

struct TasteCuration: Equatable, Codable {
  let favoriteGenres: [String]
  let favoriteWorks: [URL]
}

struct TasteTheme: Equatable, Codable {
  let moods: [String]
  let narratives: [String]
  let duckPoints: [String]
  let discussionTopics: [String]
}

// MARK: - Mock Data
#if DEBUG
extension MyFeed {
  static let mockData: [MyFeed] = [
    MyFeed(
      movieTitle: "인셉션",
      year: "2010",
      comment: "꿈 속의 꿈, 정말 대단한 영화였어요"
    ),
    MyFeed(
      movieTitle: "기생충",
      year: "2019",
      comment: "봉준호 감독의 걸작, 계급에 대한 통찰"
    ),
    MyFeed(
      movieTitle: "인터스텔라",
      year: "2014",
      comment: "시간과 사랑에 대한 가장 아름다운 영화"
    )
  ]
}
#endif
