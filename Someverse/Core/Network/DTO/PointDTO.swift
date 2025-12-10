//
//  PointDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Transaction Type

enum PointTransactionType: String, Codable {
  case charge = "CHARGE"
  case use = "USE"
  case reward = "REWARD"
  case refund = "REFUND"
}

// MARK: - Point Balance Response

struct PointBalanceResponse: Decodable {
  let userId: Int
  let pointBalance: Int
  let lumiBalance: Int?

  enum CodingKeys: String, CodingKey {
    case userId
    case pointBalance
    case lumiBalance
  }
}

// MARK: - Point Transaction List Response

struct PointTransactionListResponse: Decodable {
  let transactions: [PointTransactionDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case transactions
    case pageInfo
  }
}

// MARK: - Point Transaction DTO

struct PointTransactionDTO: Decodable {
  let transactionId: Int
  let type: String
  let amount: Int
  let balanceAfter: Int
  let reason: String
  let relatedId: Int?
  let relatedType: String?
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case transactionId
    case type
    case amount
    case balanceAfter
    case reason
    case relatedId
    case relatedType
    case createdAt
  }
}

// MARK: - Free Chat Available Response

struct FreeChatAvailableResponse: Decodable {
  let userId: Int
  let isAvailable: Bool
  let remainingCount: Int
  let maxCount: Int
  let resetAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case isAvailable
    case remainingCount
    case maxCount
    case resetAt
  }
}

// MARK: - Point Charge Request

struct PointChargeRequest: Encodable {
  let amount: Int
  let paymentMethod: String
  let receiptId: String?

  enum CodingKeys: String, CodingKey {
    case amount
    case paymentMethod
    case receiptId
  }
}

// MARK: - Point Charge Response

struct PointChargeResponse: Decodable {
  let transactionId: Int
  let userId: Int
  let amount: Int
  let balanceAfter: Int
  let chargedAt: String

  enum CodingKeys: String, CodingKey {
    case transactionId
    case userId
    case amount
    case balanceAfter
    case chargedAt
  }
}

// MARK: - Point Use Request

struct PointUseRequest: Encodable {
  let amount: Int
  let reason: String
  let relatedId: Int?
  let relatedType: String?

  enum CodingKeys: String, CodingKey {
    case amount
    case reason
    case relatedId
    case relatedType
  }
}

// MARK: - Point Use Response

struct PointUseResponse: Decodable {
  let transactionId: Int
  let userId: Int
  let amount: Int
  let balanceAfter: Int
  let usedAt: String

  enum CodingKeys: String, CodingKey {
    case transactionId
    case userId
    case amount
    case balanceAfter
    case usedAt
  }
}
