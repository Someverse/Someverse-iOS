//
//  NotificationDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Notification Type

enum NotificationType: String, Codable {
  case matching = "MATCHING"
  case chat = "CHAT"
  case like = "LIKE"
  case comment = "COMMENT"
  case system = "SYSTEM"
  case marketing = "MARKETING"
}

// MARK: - FCM Token Request

struct FCMTokenRequest: Encodable {
  let fcmToken: String
  let deviceType: String

  enum CodingKeys: String, CodingKey {
    case fcmToken
    case deviceType
  }
}

// MARK: - FCM Token Response

struct FCMTokenResponse: Decodable {
  let userId: Int
  let registered: Bool
  let registeredAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case registered
    case registeredAt
  }
}

// MARK: - Notification List Response

struct NotificationListResponse: Decodable {
  let notifications: [NotificationDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case notifications
    case pageInfo
  }
}

// MARK: - Notification DTO

struct NotificationDTO: Decodable {
  let notificationId: Int
  let type: String
  let title: String
  let body: String
  let data: NotificationDataDTO?
  let isRead: Bool
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case notificationId
    case type
    case title
    case body
    case data
    case isRead
    case createdAt
  }
}

// MARK: - Notification Data DTO

struct NotificationDataDTO: Decodable {
  let targetId: Int?
  let targetType: String?
  let senderId: Int?
  let senderNickName: String?
  let senderProfileImage: String?

  enum CodingKeys: String, CodingKey {
    case targetId
    case targetType
    case senderId
    case senderNickName
    case senderProfileImage
  }
}

// MARK: - Unread Notification Count Response

struct UnreadNotificationCountResponse: Decodable {
  let unreadCount: Int

  enum CodingKeys: String, CodingKey {
    case unreadCount
  }
}

// MARK: - Notification Read Response

struct NotificationReadResponse: Decodable {
  let notificationId: Int
  let isRead: Bool
  let readAt: String

  enum CodingKeys: String, CodingKey {
    case notificationId
    case isRead
    case readAt
  }
}

// MARK: - Read All Notifications Response

struct ReadAllNotificationsResponse: Decodable {
  let updatedCount: Int

  enum CodingKeys: String, CodingKey {
    case updatedCount
  }
}
