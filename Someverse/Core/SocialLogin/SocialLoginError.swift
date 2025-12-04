//
//  SocialLoginError.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import Foundation

enum SocialLoginError: LocalizedError {
    case notConfigured
    case loginFailed(Error)
    case cancelled

    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "소셜 로그인이 설정되지 않았습니다."
        case .loginFailed(let error):
            return "로그인 실패: \(error.localizedDescription)"
        case .cancelled:
            return "로그인이 취소되었습니다."
        }
    }
}
