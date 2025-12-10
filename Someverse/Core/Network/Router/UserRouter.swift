//
//  UserRouter.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

enum UserRouter: APIRouter {
  
  case validateNickname(nickname: String)
  case signUp(request: SignUpRequestDTO)
  case getProfile
  case updateProfile(request: ProfileUpdateRequestDTO)
  case uploadProfileImage
  
  // MARK: - Path
  
  var path: String {
    switch self {
    case .validateNickname:
      return APIConstants.Path.nicknameValidation
    case .signUp:
      return APIConstants.Path.signUp
    case .getProfile, .updateProfile:
      return APIConstants.Path.profile
    case .uploadProfileImage:
      return APIConstants.Path.profileImage
    }
  }
  
  // MARK: - Method
  
  var method: HTTPMethod {
    switch self {
    case .validateNickname:
      return .get
    case .signUp, .uploadProfileImage:
      return .post
    case .getProfile:
      return .get
    case .updateProfile:
      return .put
    }
  }
  
  // MARK: - Query Items
  
  var queryItems: [URLQueryItem]? {
    switch self {
    case .validateNickname(let nickname):
      return [URLQueryItem(name: "nickname", value: nickname)]
    default:
      return nil
    }
  }
  
  // MARK: - Body
  
  var body: Data? {
    switch self {
    case .signUp(let request):
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      return try? encoder.encode(request)
      
    case .updateProfile(let request):
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      return try? encoder.encode(request)
      
    default:
      return nil
    }
  }
  
  // MARK: - Authorization Type
  
  var authorizationType: AuthorizationType {
    switch self {
    case .validateNickname:
      return .none
    case .signUp:
      return .accessToken
    case .getProfile, .updateProfile, .uploadProfileImage:
      return .accessToken
    }
  }
}
