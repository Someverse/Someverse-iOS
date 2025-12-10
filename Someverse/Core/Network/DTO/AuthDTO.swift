//
//  AuthDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - OAuth Login Response

struct OAuthLoginResponse: Decodable {
  let userId: Int
  let email: String?
  let provider: String
  let isNewUser: Bool
  let accessToken: String
  let refreshToken: String

  enum CodingKeys: String, CodingKey {
    case userId
    case email
    case provider
    case isNewUser
    case accessToken
    case refreshToken
  }
}

// MARK: - Token Refresh Response

struct TokenRefreshResponse: Decodable {
  let accessToken: String
  let refreshToken: String

  enum CodingKeys: String, CodingKey {
    case accessToken
    case refreshToken
  }
}

// MARK: - Logout Response

struct LogoutResponse: Decodable {
  let loggedOut: Bool

  enum CodingKeys: String, CodingKey {
    case loggedOut
  }
}
