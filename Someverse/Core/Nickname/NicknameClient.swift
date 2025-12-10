//
//  NicknameClient.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUICore

enum NicknameValidationResult: Equatable, Sendable {
    case valid
    case duplicate
    case invalid

    var validationState: NicknameValidationState {
        switch self {
        case .valid:
            return .success("사용 가능한 닉네임입니다.")
        case .duplicate:
            return .error("이미 사용하고 있는 닉네임입니다.")
        case .invalid:
            return .idle
        }
    }
}

struct NicknameClient: Sendable {
    var validateNickname: @Sendable (String) async throws -> NicknameValidationResult
    var saveNickname: @Sendable (String) async throws -> Void
}

extension NicknameClient: EnvironmentKey {
    static let defaultValue: NicknameClient = NicknameClient(
        validateNickname: { _ in fatalError("닉네임 검증 에러") },
        saveNickname: { _ in fatalError("닉네임 저장 에러") }
    )

    static let testValue: NicknameClient = NicknameClient(
        validateNickname: { nickname in
            // Mock validation logic
            if nickname == "미쁜구보만" {
                return .duplicate
            } else if nickname.count >= 2 {
                return .valid
            } else {
                return .invalid
            }
        },
        saveNickname: { _ in }
    )

    /// 실제 네트워크 연동 Client
    static let liveValue: NicknameClient = NicknameClient(
        validateNickname: { nickname in
            let router = UserRouter.validateNickname(nickname: nickname)
            do {
                let response = try await NetworkManager.shared.request(
                    router,
                    type: NicknameCheckResponse.self
                )
                return response.isAvailable ? .valid : .duplicate
            } catch NetworkError.conflict {
                return .duplicate
            } catch {
                return .invalid
            }
        },
        saveNickname: { _ in
            // 닉네임 저장은 회원가입 API에서 처리
        }
    )
}

extension EnvironmentValues {
    var nicknameClient: NicknameClient {
        get { self[NicknameClient.self] }
        set { self[NicknameClient.self] = newValue }
    }
}
