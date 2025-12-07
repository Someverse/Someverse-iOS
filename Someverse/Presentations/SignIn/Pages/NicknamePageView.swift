//
//  NicknamePageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI
import Combine

// MARK: - Nickname Validation State
enum NicknameValidationState: Equatable {
    case idle
    case error(String)
    case success(String)

    var messageColor: Color {
        switch self {
        case .idle: return .clear
        case .error: return .someverseError
        case .success: return .someverseTextPrimary
        }
    }

    var message: String {
        switch self {
        case .idle: return ""
        case .error(let msg): return msg
        case .success(let msg): return msg
        }
    }

    var textColor: Color? {
        switch self {
        case .idle: return nil
        case .error: return .someverseError
        case .success: return .someverseTextTitle
        }
    }
}

// MARK: - Nickname ViewModel
@MainActor
final class NicknameViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var validationState: NicknameValidationState = .idle

    private let validateNickname: @Sendable (String) async throws -> NicknameValidationResult
    private let saveNickname: @Sendable (String) async throws -> Void
    private var validationTask: Task<Void, Never>?
    private let debounceInterval: UInt64 = 500_000_000 // 500ms in nanoseconds

    var isNicknameValid: Bool {
        if case .success = validationState {
            return true
        }
        return false
    }

    init(
        validateNickname: @escaping @Sendable (String) async throws -> NicknameValidationResult,
        saveNickname: @escaping @Sendable (String) async throws -> Void
    ) {
        self.validateNickname = validateNickname
        self.saveNickname = saveNickname
    }

    func performValidationWithDebounce() {
        validationTask?.cancel()

        guard !nickname.isEmpty else {
            validationState = .idle
            return
        }

        validationTask = Task {
            try? await Task.sleep(nanoseconds: debounceInterval)

            guard !Task.isCancelled else { return }

            do {
                let result = try await validateNickname(nickname)
                guard !Task.isCancelled else { return }
                validationState = result.validationState
            } catch {
                guard !Task.isCancelled else { return }
                validationState = .error("닉네임 검증 중 오류가 발생했습니다.")
            }
        }
    }

    func cancelValidation() {
        validationTask?.cancel()
    }

    func handleSaveNickname() async {
        do {
            try await saveNickname(nickname)
        } catch {
            validationState = .error("닉네임 저장 중 오류가 발생했습니다.")
        }
    }
}

// MARK: - Nickname Page View
struct NicknamePageView: View {
    @ObservedObject var viewModel: NicknameViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            headerSection
            nicknameTextField
        }
        .padding(.horizontal, 24)
        .onChange(of: viewModel.nickname) { _ in
            viewModel.performValidationWithDebounce()
        }
        .onDisappear {
            viewModel.cancelValidation()
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text("SOMEVERSE")
                    .font(.someverseBodyRegular)
                    .fontWeight(.bold)
                    .foregroundColor(.someversePrimary)

                Text("가 처음이시군요!")
                    .font(.someverseHeadline)
                    .foregroundColor(.someverseTextTitle)
            }

            Text("닉네임을 정해주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.someverseTextTitle)

            Text("흥미로운 닉네임일수록 매칭률이 높아져요!")
                .font(.someverseBodyRegular)
                .foregroundColor(.someverseTextSecondary)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Nickname TextField
private extension NicknamePageView {
    var nicknameTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .font(.someverseBody)
                    .foregroundColor(.someverseTextPlaceholder)

                TextField("닉네임을 설정하세요", text: $viewModel.nickname)
                    .font(.someverseBody)
                    .foregroundColor(viewModel.validationState.textColor ?? .someverseTextTitle)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.someverseBackground)
            .cornerRadius(8)

            if !viewModel.validationState.message.isEmpty {
                Text(viewModel.validationState.message)
                    .font(.someverseLabel)
                    .foregroundColor(viewModel.validationState.messageColor)
                    .padding(.leading, 4)
            }
        }
    }
}

#Preview {
    let client = NicknameClient.testValue
    let viewModel = NicknameViewModel(
        validateNickname: client.validateNickname,
        saveNickname: client.saveNickname
    )
    return NicknamePageView(viewModel: viewModel)
}
