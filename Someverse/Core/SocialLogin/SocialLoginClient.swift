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
}

extension EnvironmentValues {
    var socialLoginClient: SocialLoginClient {
        get { self[SocialLoginClient.self] }
        set { self[SocialLoginClient.self] = newValue }
    }
}
