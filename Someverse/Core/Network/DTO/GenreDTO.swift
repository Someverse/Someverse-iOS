//
//  GenreDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Genre List Response

struct GenreListResponse: Decodable {
  let genres: [GenreDTO]

  enum CodingKeys: String, CodingKey {
    case genres
  }
}

// MARK: - Genre DTO

struct GenreDTO: Decodable {
  let id: Int
  let name: String
  let type: String
  let externalId: Int?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case type
    case externalId
  }
}
