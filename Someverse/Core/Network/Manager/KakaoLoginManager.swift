//
//  KakaoLoginManager.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation
// import KakaoSDKUser  // 카카오 SDK 설치 후 주석 해제
// import KakaoSDKAuth

final class KakaoLoginManager {
  static let shared = KakaoLoginManager()
  
  private let networkManager = NetworkManager.shared
  private let tokenManager = TokenManager.shared
  
  private init() {}
  
  // MARK: - Kakao Login Flow
  
  /// 카카오 로그인 수행 (SDK 연동)
  /// - Returns: 카카오 OAuth 토큰
  func handleKakaoLogin() async throws -> String {
    // TODO: 카카오 SDK 설치 후 구현
    // 현재는 placeholder
#if DEBUG
    print("KakaoLoginManager: 카카오 로그인 시도")
#endif
    
    // 실제 구현 시:
    // if UserApi.isKakaoTalkLoginAvailable() {
    //     return try await loginWithKakaoTalk()
    // } else {
    //     return try await loginWithKakaoAccount()
    // }
    
    throw KakaoLoginError.sdkNotConfigured
  }
  
  /// 카카오톡 앱으로 로그인
  private func loginWithKakaoTalk() async throws -> String {
    // TODO: 카카오 SDK 설치 후 구현
    // return try await withCheckedThrowingContinuation { continuation in
    //     UserApi.shared.loginWithKakaoTalk { oauthToken, error in
    //         if let error = error {
    //             continuation.resume(throwing: KakaoLoginError.loginFailed(error))
    //         } else if let token = oauthToken?.accessToken {
    //             continuation.resume(returning: token)
    //         } else {
    //             continuation.resume(throwing: KakaoLoginError.tokenNotFound)
    //         }
    //     }
    // }
    throw KakaoLoginError.sdkNotConfigured
  }
  
  /// 카카오 계정으로 로그인 (웹뷰)
  private func loginWithKakaoAccount() async throws -> String {
    // TODO: 카카오 SDK 설치 후 구현
    throw KakaoLoginError.sdkNotConfigured
  }
  
  // MARK: - Server Authentication

  /// 카카오 OAuth 토큰으로 서버 인증
  /// - Parameter oauthToken: 카카오에서 받은 OAuth 토큰
  /// - Returns: 로그인 응답 (서버 토큰 포함)
  func completeLogin(oauthToken: String) async throws -> OAuthLoginResponse {
    let deviceToken = await getDeviceToken()

    let router = AuthRouter.kakaoLogin(oauthToken: oauthToken, deviceToken: deviceToken)
    let response = try await networkManager.request(router, type: OAuthLoginResponse.self)

    // 토큰 저장
    tokenManager.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken
    )
    tokenManager.saveUserInfo(userId: String(response.userId))
    
#if DEBUG
    print("KakaoLoginManager: 서버 인증 완료 - userId: \(response.userId)")
#endif
    
    return response
  }
  
  // MARK: - Device Token
  
  private func getDeviceToken() async -> String {
    // TODO: FCM 또는 APNs 토큰 반환
    // 현재는 빈 문자열 반환
    return ""
  }
}

// MARK: - Kakao Login Error

enum KakaoLoginError: Error {
  case sdkNotConfigured
  case loginFailed(Error)
  case tokenNotFound
  case serverAuthFailed
  
  var errorMessage: String {
    switch self {
    case .sdkNotConfigured:
      return "카카오 SDK가 설정되지 않았습니다."
    case .loginFailed(let error):
      return "카카오 로그인 실패: \(error.localizedDescription)"
    case .tokenNotFound:
      return "카카오 토큰을 가져올 수 없습니다."
    case .serverAuthFailed:
      return "서버 인증에 실패했습니다."
    }
  }
}
