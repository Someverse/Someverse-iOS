//
//  FeedDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Feed Type

enum FeedType: String, Codable {
  case movie = "MOVIE"
  case music = "MUSIC"
  case text = "TEXT"
}

// MARK: - Feed Create Request

struct FeedCreateRequest: Encodable {
  let feedType: String
  let movieId: Int?
  let musicId: Int?
  let content: String?
  let imageUrls: [String]?

  enum CodingKeys: String, CodingKey {
    case feedType
    case movieId
    case musicId
    case content
    case imageUrls
  }
}

// MARK: - Feed Update Request

struct FeedUpdateRequest: Encodable {
  let content: String?
  let imageUrls: [String]?

  enum CodingKeys: String, CodingKey {
    case content
    case imageUrls
  }
}

// MARK: - Feed Create Response

struct FeedCreateResponse: Decodable {
  let feedId: Int
  let userId: Int
  let feedType: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case feedId
    case userId
    case feedType
    case createdAt
  }
}

// MARK: - Feed List Response

struct FeedListResponse: Decodable {
  let feeds: [FeedDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case feeds
    case pageInfo
  }
}

// MARK: - Feed DTO

struct FeedDTO: Decodable {
  let feedId: Int
  let userId: Int
  let userNickName: String
  let userProfileImage: String?
  let feedType: String
  let movie: FeedMovieDTO?
  let music: FeedMusicDTO?
  let content: String?
  let imageUrls: [String]?
  let likeCount: Int
  let commentCount: Int
  let isLiked: Bool
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case feedId
    case userId
    case userNickName
    case userProfileImage
    case feedType
    case movie
    case music
    case content
    case imageUrls
    case likeCount
    case commentCount
    case isLiked
    case createdAt
    case updatedAt
  }
}

// MARK: - Feed Movie DTO

struct FeedMovieDTO: Decodable {
  let movieId: Int
  let title: String
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case movieId
    case title
    case posterPath
  }
}

// MARK: - Feed Music DTO

struct FeedMusicDTO: Decodable {
  let musicId: Int
  let title: String
  let artist: String
  let albumArtUrl: String?

  enum CodingKeys: String, CodingKey {
    case musicId
    case title
    case artist
    case albumArtUrl
  }
}

// MARK: - Feed Detail Response

struct FeedDetailResponse: Decodable {
  let feed: FeedDTO
  let comments: [FeedCommentDTO]?

  enum CodingKeys: String, CodingKey {
    case feed
    case comments
  }
}

// MARK: - Feed Comment DTO

struct FeedCommentDTO: Decodable {
  let commentId: Int
  let userId: Int
  let userNickName: String
  let userProfileImage: String?
  let content: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case commentId
    case userId
    case userNickName
    case userProfileImage
    case content
    case createdAt
  }
}

// MARK: - Feed Like Response

struct FeedLikeResponse: Decodable {
  let feedId: Int
  let userId: Int
  let isLiked: Bool
  let likeCount: Int

  enum CodingKeys: String, CodingKey {
    case feedId
    case userId
    case isLiked
    case likeCount
  }
}

// MARK: - Comment Create Request

struct CommentCreateRequest: Encodable {
  let content: String

  enum CodingKeys: String, CodingKey {
    case content
  }
}

// MARK: - Comment Create Response

struct CommentCreateResponse: Decodable {
  let commentId: Int
  let feedId: Int
  let userId: Int
  let content: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case commentId
    case feedId
    case userId
    case content
    case createdAt
  }
}
