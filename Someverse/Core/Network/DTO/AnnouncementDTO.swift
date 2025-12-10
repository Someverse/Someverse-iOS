//
//  AnnouncementDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Announcement List Response

struct AnnouncementListResponse: Decodable {
  let announcements: [AnnouncementDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case announcements
    case pageInfo
  }
}

// MARK: - Announcement DTO

struct AnnouncementDTO: Decodable {
  let id: Int
  let title: String
  let content: String
  let category: String?
  let isPinned: Bool
  let viewCount: Int?
  let createdAt: String
  let updatedAt: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case content
    case category
    case isPinned
    case viewCount
    case createdAt
    case updatedAt
  }
}

// MARK: - Announcement Detail Response

struct AnnouncementDetailResponse: Decodable {
  let id: Int
  let title: String
  let content: String
  let category: String?
  let isPinned: Bool
  let viewCount: Int
  let attachments: [AttachmentDTO]?
  let createdAt: String
  let updatedAt: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case content
    case category
    case isPinned
    case viewCount
    case attachments
    case createdAt
    case updatedAt
  }
}

// MARK: - Attachment DTO

struct AttachmentDTO: Decodable {
  let id: Int
  let fileName: String
  let fileUrl: String
  let fileSize: Int?
  let mimeType: String?

  enum CodingKeys: String, CodingKey {
    case id
    case fileName
    case fileUrl
    case fileSize
    case mimeType
  }
}
