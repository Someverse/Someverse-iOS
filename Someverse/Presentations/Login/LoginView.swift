//
//  LoginView.swift
//  Someverse
//
//  Created by 박채현 on 11/28/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.socialLoginClient.kakaoLogin) private var kakaoLogin
    @Environment(\.socialLoginClient.appleLogin) private var appleLogin
    @Environment(\.nicknameClient) private var nicknameClient
    @State private var navigateToSignUp = false
    @StateObject private var coordinator = SignInCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack(spacing: 0) {
                Spacer()

                // Login Buttons
                VStack(spacing: 12) {
                    SocialLoginButton(type: .kakao) {
                        Task {
                            _ = try await kakaoLogin()
                            navigateToSignUp = true
                        }
                    }

                    SocialLoginButton(type: .apple) {
                        Task {
                            _ = try await appleLogin()
                            navigateToSignUp = true
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
                    .frame(height: 24)

                // Footer
                VStack(spacing: 8) {
                    Text("사업자 정보 ▶")
                        .font(.someverseCaption)
                        .foregroundColor(.someverseTextTertiary)

                    Text("서비스 이용약관, 개인정보 처리방침, 위치정보, 이용약관에\n동의하게 됩니다.")
                        .font(.someverseCaption)
                        .foregroundColor(.someverseTextSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }
                .padding(.bottom, 40)
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                NicknameView(viewModel: NicknameViewModel(
                    validateNickname: nicknameClient.validateNickname,
                    saveNickname: nicknameClient.saveNickname,
                    coordinator: coordinator
                ))
            }
            .navigationDestination(for: SignInRoute.self) { route in
                destinationView(for: route)
            }
        }
    }

    @ViewBuilder
    private func destinationView(for route: SignInRoute) -> some View {
        switch route {
        case .nickname:
            NicknameView(viewModel: NicknameViewModel(
                validateNickname: nicknameClient.validateNickname,
                saveNickname: nicknameClient.saveNickname,
                coordinator: coordinator
            ))
        case .gender:
            GenderView()
        case .birthday:
            BirthdayView()
        case .area:
            AreaView()
        case .profileImage:
            ProfileImageView()
        case .taste:
            TasteView()
        case .approval:
            ApprovalPendingView()
        }
    }
}

#Preview {
    LoginView()
}
