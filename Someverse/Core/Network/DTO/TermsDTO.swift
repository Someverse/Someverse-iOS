//
//  TermsDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Terms List Response

struct TermsListResponse: Decodable {
  let terms: [TermsDTO]

  enum CodingKeys: String, CodingKey {
    case terms
  }
}

// MARK: - Terms DTO

struct TermsDTO: Decodable {
  let id: Int
  let title: String
  let content: String
  let isRequired: Bool
  let version: String
  let effectiveDate: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case content
    case isRequired
    case version
    case effectiveDate
    case createdAt
  }
}

// MARK: - Terms Detail Response

struct TermsDetailResponse: Decodable {
  let id: Int
  let title: String
  let content: String
  let isRequired: Bool
  let version: String
  let effectiveDate: String
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case content
    case isRequired
    case version
    case effectiveDate
    case createdAt
    case updatedAt
  }
}

// MARK: - User Terms Agreement Response

struct UserTermsAgreementResponse: Decodable {
  let userId: Int
  let agreements: [UserTermsAgreementDTO]

  enum CodingKeys: String, CodingKey {
    case userId
    case agreements
  }
}

struct UserTermsAgreementDTO: Decodable {
  let termsId: Int
  let termsTitle: String
  let agreed: Bool
  let agreedAt: String?

  enum CodingKeys: String, CodingKey {
    case termsId
    case termsTitle
    case agreed
    case agreedAt
  }
}
