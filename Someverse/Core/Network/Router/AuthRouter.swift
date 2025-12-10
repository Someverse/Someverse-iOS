//
//  AuthRouter.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

enum AuthRouter: APIRouter {
  
  case kakaoLogin(oauthToken: String, deviceToken: String)
  case appleLogin(idToken: String, deviceToken: String, nickname: String?)
  case refreshToken
  case logout
  
  // MARK: - Path
  
  var path: String {
    switch self {
    case .kakaoLogin:
      return APIConstants.Path.kakaoLogin
    case .appleLogin:
      return APIConstants.Path.appleLogin
    case .refreshToken:
      return APIConstants.Path.refresh
    case .logout:
      return APIConstants.Path.logout
    }
  }
  
  // MARK: - Method
  
  var method: HTTPMethod {
    switch self {
    case .kakaoLogin, .appleLogin, .logout:
      return .post
    case .refreshToken:
      return .get
    }
  }
  
  // MARK: - Body
  
  var body: Data? {
    switch self {
    case .kakaoLogin(let oauthToken, let deviceToken):
      let params: [String: Any] = [
        "oauthToken": oauthToken,
        "deviceToken": deviceToken
      ]
      return try? JSONSerialization.data(withJSONObject: params)
      
    case .appleLogin(let idToken, let deviceToken, let nickname):
      var params: [String: Any] = [
        "idToken": idToken,
        "deviceToken": deviceToken
      ]
      if let nickname = nickname {
        params["nickname"] = nickname
      }
      return try? JSONSerialization.data(withJSONObject: params)
      
    case .refreshToken, .logout:
      return nil
    }
  }
  
  // MARK: - Authorization Type
  
  var authorizationType: AuthorizationType {
    switch self {
    case .kakaoLogin, .appleLogin:
      return .none
    case .refreshToken:
      return .refreshToken
    case .logout:
      return .accessToken
    }
  }
}
