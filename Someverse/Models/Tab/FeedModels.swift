//
//  FeedModels.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import Foundation

struct Feed: Identifiable, Equatable, Codable {
  let id: UUID
  let movieImageURL: URL?
  let movieTitle: String
  let movieYear: String
  let authorNickname: String
  let authorProfileImageURL: URL?
  let comment: String

  init(
    id: UUID = UUID(),
    movieImageURL: URL? = nil,
    movieTitle: String,
    movieYear: String,
    authorNickname: String,
    authorProfileImageURL: URL? = nil,
    comment: String
  ) {
    self.id = id
    self.movieImageURL = movieImageURL
    self.movieTitle = movieTitle
    self.movieYear = movieYear
    self.authorNickname = authorNickname
    self.authorProfileImageURL = authorProfileImageURL
    self.comment = comment
  }
}

// MARK: - Mock Data
#if DEBUG
extension Feed {
  static let mockData: [Feed] = [
    Feed(
      movieTitle: "어쩔수가없다",
      movieYear: "2025",
      authorNickname: "마포구보안관2",
      comment: "박찬욱 영화중 제일 웃기지만\n다소 불친절하다."
    ),
    Feed(
      movieTitle: "인터스텔라",
      movieYear: "2014",
      authorNickname: "드라마메이커",
      comment: "시간과 사랑에 대한\n가장 아름다운 영화"
    ),
    Feed(
      movieTitle: "기생충",
      movieYear: "2019",
      authorNickname: "영화덕후",
      comment: "봉준호 감독의 걸작\n계급에 대한 통찰"
    )
  ]
}
#endif
