//
//  ChatDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Message Type

enum MessageType: String, Codable {
  case text = "TEXT"
  case image = "IMAGE"
  case system = "SYSTEM"
}

// MARK: - Chat Room Create Request

struct ChatRoomCreateRequest: Encodable {
  let receiverId: Int
  let firstMessage: String?

  enum CodingKeys: String, CodingKey {
    case receiverId
    case firstMessage
  }
}

// MARK: - Message Send Request

struct MessageSendRequest: Encodable {
  let content: String
  let messageType: String

  enum CodingKeys: String, CodingKey {
    case content
    case messageType
  }
}

// MARK: - Chat Room Response

struct ChatRoomResponse: Decodable {
  let chatRoomId: Int
  let participants: [ChatParticipantDTO]
  let lastMessage: MessageDTO?
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case chatRoomId
    case participants
    case lastMessage
    case createdAt
  }
}

// MARK: - Chat Participant DTO

struct ChatParticipantDTO: Decodable {
  let userId: Int
  let nickName: String
  let profileImage: String?
  let isOnline: Bool?

  enum CodingKeys: String, CodingKey {
    case userId
    case nickName
    case profileImage
    case isOnline
  }
}

// MARK: - Chat Room List Response

struct ChatRoomListResponse: Decodable {
  let chatRooms: [ChatRoomDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case chatRooms
    case pageInfo
  }
}

// MARK: - Chat Room DTO

struct ChatRoomDTO: Decodable {
  let chatRoomId: Int
  let otherUser: ChatParticipantDTO
  let lastMessage: LastMessageDTO?
  let unreadCount: Int
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case chatRoomId
    case otherUser
    case lastMessage
    case unreadCount
    case updatedAt
  }
}

// MARK: - Last Message DTO

struct LastMessageDTO: Decodable {
  let messageId: Int
  let content: String
  let messageType: String
  let sentAt: String

  enum CodingKeys: String, CodingKey {
    case messageId
    case content
    case messageType
    case sentAt
  }
}

// MARK: - Message List Response

struct MessageListResponse: Decodable {
  let messages: [MessageDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case messages
    case pageInfo
  }
}

// MARK: - Message DTO

struct MessageDTO: Decodable {
  let messageId: Int
  let chatRoomId: Int
  let senderId: Int
  let senderNickName: String
  let senderProfileImage: String?
  let content: String
  let messageType: String
  let isRead: Bool
  let sentAt: String

  enum CodingKeys: String, CodingKey {
    case messageId
    case chatRoomId
    case senderId
    case senderNickName
    case senderProfileImage
    case content
    case messageType
    case isRead
    case sentAt
  }
}

// MARK: - Unread Count Response

struct UnreadCountResponse: Decodable {
  let totalUnreadCount: Int
  let chatRoomUnreadCounts: [ChatRoomUnreadDTO]?

  enum CodingKeys: String, CodingKey {
    case totalUnreadCount
    case chatRoomUnreadCounts
  }
}

struct ChatRoomUnreadDTO: Decodable {
  let chatRoomId: Int
  let unreadCount: Int

  enum CodingKeys: String, CodingKey {
    case chatRoomId
    case unreadCount
  }
}

// MARK: - Daily Free Chat Count Response

struct DailyFreeChatCountResponse: Decodable {
  let userId: Int
  let remainingFreeChats: Int
  let maxFreeChats: Int
  let resetAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case remainingFreeChats
    case maxFreeChats
    case resetAt
  }
}

// MARK: - Chat Room Exit Response

struct ChatRoomExitResponse: Decodable {
  let chatRoomId: Int
  let exitedAt: String

  enum CodingKeys: String, CodingKey {
    case chatRoomId
    case exitedAt
  }
}
