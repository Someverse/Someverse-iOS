//
//  MatchingDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Daily Matching Response

struct DailyMatchingResponse: Decodable {
  let matchingDate: String
  let users: [MatchingUserDTO]
  let remainingRefreshCount: Int

  enum CodingKeys: String, CodingKey {
    case matchingDate
    case users
    case remainingRefreshCount
  }
}

// MARK: - Matching User DTO

struct MatchingUserDTO: Decodable {
  let userId: Int
  let nickName: String
  let age: Int
  let gender: String
  let profileImages: [String]
  let bio: String?
  let job: String?
  let locations: [LocationDTO]
  let matchingScore: Int
  let commonGenres: [MatchingGenreDTO]?
  let commonMovies: [MatchingMovieDTO]?

  enum CodingKeys: String, CodingKey {
    case userId
    case nickName
    case age
    case gender
    case profileImages
    case bio
    case job
    case locations
    case matchingScore
    case commonGenres
    case commonMovies
  }
}

// MARK: - Matching Genre DTO

struct MatchingGenreDTO: Decodable {
  let genreId: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case genreId
    case name
  }
}

// MARK: - Matching Movie DTO

struct MatchingMovieDTO: Decodable {
  let movieId: Int
  let title: String
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case movieId
    case title
    case posterPath
  }
}

// MARK: - Matching History Response

struct MatchingHistoryResponse: Decodable {
  let history: [MatchingHistoryDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case history
    case pageInfo
  }
}

// MARK: - Matching History DTO

struct MatchingHistoryDTO: Decodable {
  let matchingId: Int
  let matchedUser: MatchingHistoryUserDTO
  let matchingScore: Int
  let matchedAt: String
  let status: String

  enum CodingKeys: String, CodingKey {
    case matchingId
    case matchedUser
    case matchingScore
    case matchedAt
    case status
  }
}

// MARK: - Matching History User DTO

struct MatchingHistoryUserDTO: Decodable {
  let userId: Int
  let nickName: String
  let age: Int
  let profileImage: String?

  enum CodingKeys: String, CodingKey {
    case userId
    case nickName
    case age
    case profileImage
  }
}

// MARK: - Like/Pass Request

struct MatchingActionRequest: Encodable {
  let targetUserId: Int
  let action: String

  enum CodingKeys: String, CodingKey {
    case targetUserId
    case action
  }
}

// MARK: - Like/Pass Response

struct MatchingActionResponse: Decodable {
  let userId: Int
  let targetUserId: Int
  let action: String
  let isMatched: Bool
  let chatRoomId: Int?
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case targetUserId
    case action
    case isMatched
    case chatRoomId
    case createdAt
  }
}

// MARK: - Refresh Matching Response

struct RefreshMatchingResponse: Decodable {
  let users: [MatchingUserDTO]
  let remainingRefreshCount: Int
  let nextRefreshAt: String?

  enum CodingKeys: String, CodingKey {
    case users
    case remainingRefreshCount
    case nextRefreshAt
  }
}
