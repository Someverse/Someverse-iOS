//
//  AppleLoginManager.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation
import AuthenticationServices

@MainActor
final class AppleLoginManager: NSObject {
  static let shared = AppleLoginManager()
  
  private let networkManager = NetworkManager.shared
  private let tokenManager = TokenManager.shared
  
  private var continuation: CheckedContinuation<AppleAuthResult, Error>?
  
  private override init() {
    super.init()
  }
  
  // MARK: - Apple Login Flow
  
  /// Apple 로그인 수행
  /// - Returns: Apple ID Token 및 닉네임
  func handleAppleLogin() async throws -> AppleAuthResult {
    return try await withCheckedThrowingContinuation { continuation in
      self.continuation = continuation
      
      let provider = ASAuthorizationAppleIDProvider()
      let request = provider.createRequest()
      request.requestedScopes = [.fullName, .email]
      
      let controller = ASAuthorizationController(authorizationRequests: [request])
      controller.delegate = self
      controller.presentationContextProvider = self
      controller.performRequests()
    }
  }
  
  // MARK: - Server Authentication
  
  /// Apple ID Token으로 서버 인증
  /// - Parameters:
  ///   - idToken: Apple에서 받은 ID Token
  ///   - nickname: 사용자 이름 (첫 로그인 시에만 제공)
  /// - Returns: 로그인 응답 (서버 토큰 포함)
  func completeLogin(idToken: String, nickname: String?) async throws -> OAuthLoginResponse {
    let deviceToken = await getDeviceToken()

    let router = AuthRouter.appleLogin(
      idToken: idToken,
      deviceToken: deviceToken,
      nickname: nickname
    )
    let response = try await networkManager.request(router, type: OAuthLoginResponse.self)

    // 토큰 저장
    tokenManager.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken
    )
    tokenManager.saveUserInfo(userId: String(response.userId))
    
#if DEBUG
    print("AppleLoginManager: 서버 인증 완료 - userId: \(response.userId)")
#endif
    
    return response
  }
  
  // MARK: - Device Token
  
  private func getDeviceToken() async -> String {
    // TODO: FCM 또는 APNs 토큰 반환
    return ""
  }
}

// MARK: - ASAuthorizationControllerDelegate

extension AppleLoginManager: ASAuthorizationControllerDelegate {
  
  nonisolated func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    Task { @MainActor in
      guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let identityToken = credential.identityToken,
            let idTokenString = String(data: identityToken, encoding: .utf8) else {
        continuation?.resume(throwing: AppleLoginError.tokenNotFound)
        continuation = nil
        return
      }
      
      // 닉네임 추출 (첫 로그인 시에만 제공)
      var nickname: String?
      if let fullName = credential.fullName {
        let givenName = fullName.givenName ?? ""
        let familyName = fullName.familyName ?? ""
        let name = "\(familyName)\(givenName)".trimmingCharacters(in: .whitespaces)
        if !name.isEmpty {
          nickname = name
        }
      }
      
      let result = AppleAuthResult(idToken: idTokenString, nickname: nickname)
      continuation?.resume(returning: result)
      continuation = nil
    }
  }
  
  nonisolated func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: Error
  ) {
    Task { @MainActor in
      if let authError = error as? ASAuthorizationError {
        switch authError.code {
        case .canceled:
          continuation?.resume(throwing: AppleLoginError.userCanceled)
        case .failed:
          continuation?.resume(throwing: AppleLoginError.authorizationFailed)
        case .invalidResponse:
          continuation?.resume(throwing: AppleLoginError.invalidResponse)
        case .notHandled:
          continuation?.resume(throwing: AppleLoginError.notHandled)
        case .unknown:
          continuation?.resume(throwing: AppleLoginError.unknown)
        @unknown default:
          continuation?.resume(throwing: AppleLoginError.unknown)
        }
      } else {
        continuation?.resume(throwing: AppleLoginError.loginFailed(error))
      }
      continuation = nil
    }
  }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
  
  nonisolated func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    // 현재 활성 윈도우 반환
    guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = scene.windows.first else {
      return UIWindow()
    }
    return window
  }
}

// MARK: - Apple Auth Result

struct AppleAuthResult {
  let idToken: String
  let nickname: String?
}

// MARK: - Apple Login Error

enum AppleLoginError: Error {
  case tokenNotFound
  case userCanceled
  case authorizationFailed
  case invalidResponse
  case notHandled
  case unknown
  case loginFailed(Error)
  case serverAuthFailed
  
  var errorMessage: String {
    switch self {
    case .tokenNotFound:
      return "Apple ID 토큰을 가져올 수 없습니다."
    case .userCanceled:
      return "로그인이 취소되었습니다."
    case .authorizationFailed:
      return "인증에 실패했습니다."
    case .invalidResponse:
      return "유효하지 않은 응답입니다."
    case .notHandled:
      return "처리되지 않은 요청입니다."
    case .unknown:
      return "알 수 없는 오류가 발생했습니다."
    case .loginFailed(let error):
      return "Apple 로그인 실패: \(error.localizedDescription)"
    case .serverAuthFailed:
      return "서버 인증에 실패했습니다."
    }
  }
}
