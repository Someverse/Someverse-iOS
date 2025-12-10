//
//  SocialLoginClient.swift
//  Someverse
//
//  Created by 박채현 on 11/28/25.
//

import SwiftUICore

struct SocialLoginClient: Sendable {
    var kakaoLogin: @Sendable () async throws -> SocialLoginModel
    var appleLogin: @Sendable () async throws -> SocialLoginModel
}

extension SocialLoginClient: EnvironmentKey {
    static let defaultValue: SocialLoginClient = SocialLoginClient(
        kakaoLogin: { throw SocialLoginError.notConfigured },
        appleLogin: { throw SocialLoginError.notConfigured }
    )

    static let testValue: SocialLoginClient = SocialLoginClient(
        kakaoLogin: { SocialLoginModel.mock },
        appleLogin: { SocialLoginModel.mock }
    )

    /// 실제 네트워크 연동 Client
    static let liveValue: SocialLoginClient = SocialLoginClient(
        kakaoLogin: {
            let manager = KakaoLoginManager.shared
            let oauthToken = try await manager.handleKakaoLogin()
            let response = try await manager.completeLogin(oauthToken: oauthToken)
            return SocialLoginModel(token: response.accessToken)
        },
        appleLogin: {
            let manager = await AppleLoginManager.shared
            let result = try await manager.handleAppleLogin()
            let response = try await manager.completeLogin(idToken: result.idToken, nickname: result.nickname)
            return SocialLoginModel(token: response.accessToken)
        }
    )
}

extension EnvironmentValues {
    var socialLoginClient: SocialLoginClient {
        get { self[SocialLoginClient.self] }
        set { self[SocialLoginClient.self] = newValue }
    }
}
