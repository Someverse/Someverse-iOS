//
//  NicknameViewModel.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI
import Combine

@MainActor
final class NicknameViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var validationState: NicknameValidationState = .idle

    private let validateNickname: @Sendable (String) async throws -> NicknameValidationResult
    private let saveNickname: @Sendable (String) async throws -> Void
    private let coordinator: SignInCoordinator

    var isNicknameValid: Bool {
        if case .success = validationState {
            return true
        }
        return false
    }

    init(
        validateNickname: @escaping @Sendable (String) async throws -> NicknameValidationResult,
        saveNickname: @escaping @Sendable (String) async throws -> Void,
        coordinator: SignInCoordinator
    ) {
        self.validateNickname = validateNickname
        self.saveNickname = saveNickname
        self.coordinator = coordinator
    }

    func performValidation() async {
        guard !nickname.isEmpty else {
            validationState = .idle
            return
        }

        do {
            let result = try await validateNickname(nickname)
            validationState = result.validationState
        } catch {
            validationState = .error("닉네임 검증 중 오류가 발생했습니다.")
        }
    }

    func handleSaveNickname() async {
        do {
            try await saveNickname(nickname)
            print("닉네임 저장 완료: \(nickname)")
            coordinator.navigate(to: .gender)
        } catch {
            validationState = .error("닉네임 저장 중 오류가 발생했습니다.")
        }
    }
}
