//
//  NicknameError.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import Foundation

enum NicknameError: LocalizedError {
    case validationFailed
    case saveFailed
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .validationFailed:
            return "닉네임 검증 중 오류가 발생했습니다."
        case .saveFailed:
            return "닉네임 저장 중 오류가 발생했습니다."
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        }
    }
}
