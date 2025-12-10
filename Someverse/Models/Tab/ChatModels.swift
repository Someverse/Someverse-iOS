//
//  ChatModels.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import Foundation

struct ChatRoom: Identifiable, Equatable, Codable {
  let id: UUID
  let profileImageURL: URL?
  let nickname: String
  let lastMessage: String
  let lastMessageTime: Date
  let unreadCount: Int

  init(
    id: UUID = UUID(),
    profileImageURL: URL? = nil,
    nickname: String,
    lastMessage: String,
    lastMessageTime: Date,
    unreadCount: Int
  ) {
    self.id = id
    self.profileImageURL = profileImageURL
    self.nickname = nickname
    self.lastMessage = lastMessage
    self.lastMessageTime = lastMessageTime
    self.unreadCount = unreadCount
  }

  // MARK: - Computed Properties (캐싱 최적화)
  var formattedUnreadCount: String {
    unreadCount > 99 ? "99+" : "\(unreadCount)"
  }

  var formattedTime: String {
    lastMessageTime.chatTimeString
  }

  var hasUnread: Bool {
    unreadCount > 0
  }
}

struct WaitingMembers: Equatable {
  let count: Int
  let lastUpdated: Date

  // MARK: - Computed Properties (캐싱 최적화)
  var formattedCount: String {
    count > 99 ? "99+" : "\(count)"
  }

  var formattedTime: String {
    lastUpdated.chatTimeString
  }
}

// MARK: - Mock Data
#if DEBUG
extension ChatRoom {
  static let mockData: [ChatRoom] = [
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 99
    ),
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 1
    ),
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 1
    ),
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 1
    ),
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 1
    ),
    ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 1
    )
  ]
}
#endif
