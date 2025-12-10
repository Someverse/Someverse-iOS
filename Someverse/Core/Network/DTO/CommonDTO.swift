//
//  CommonDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - API Response Wrapper

struct APIResponse<T: Decodable>: Decodable {
  let success: Bool
  let code: String
  let message: String
  let data: T?
}

// MARK: - Empty Response (데이터 없는 응답용)

struct EmptyResponse: Decodable {}

// MARK: - Page Info

struct PageInfo: Decodable {
  let page: Int
  let size: Int
  let totalElements: Int
  let totalPages: Int
  let isFirst: Bool
  let isLast: Bool

  enum CodingKeys: String, CodingKey {
    case page
    case size
    case totalElements
    case totalPages
    case isFirst = "first"
    case isLast = "last"
  }
}

// MARK: - Paginated Response

struct PaginatedResponse<T: Decodable>: Decodable {
  let content: [T]
  let pageInfo: PageInfo

  enum CodingKeys: String, CodingKey {
    case content
    case pageInfo
  }
}
