//
//  RegionDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Region List Response

struct RegionListResponse: Decodable {
  let regions: [RegionDTO]

  enum CodingKeys: String, CodingKey {
    case regions
  }
}

// MARK: - Region DTO

struct RegionDTO: Decodable {
  let city: String
  let districts: [String]

  enum CodingKeys: String, CodingKey {
    case city
    case districts
  }
}
