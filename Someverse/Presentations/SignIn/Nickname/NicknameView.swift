//
//  NicknameView.swift
//  Someverse
//
//  Created by 박채현 on 12/1/25.
//

import SwiftUI

struct NicknameView: View {
    @StateObject private var viewModel: NicknameViewModel

    init(viewModel: NicknameViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("회원가입")
                .font(.someverseBody)
                .foregroundColor(.someverseTextPrimary)
                .padding(.top, 20)

            Spacer()
                .frame(height: 40)

            // Title
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text("SOMEVERSE")
                        .font(.someverseBodyRegular)
                        .fontWeight(.bold)
                        .foregroundColor(.someversePrimary)

                    Text("가 처음이시군요!")
                        .font(.someverseHeadline)
                        .foregroundColor(.black)
                }

                Text("닉네임을 정해주세요.")
                    .font(.someverseHeadline)
                    .foregroundColor(.black)

                Text("중미로운 닉네임일수록 매칭률이 높아져요!")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
                    .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 32)

            // TextField
            NicknameTextField(
                text: $viewModel.nickname,
                placeholder: "닉네임을 설정하세요",
                validationState: viewModel.validationState
            )
            .padding(.horizontal, 24)
            .task(id: viewModel.nickname) {
                await viewModel.performValidation()
            }

            Spacer()

            // Page Indicator
            PageIndicator(totalPages: 5, currentPage: 0)
                .padding(.bottom, 16)

            // CTA Button
            CTAButton(
                title: "닉네임 결정하기",
                isEnabled: viewModel.isNicknameValid
            ) {
                Task {
                    await viewModel.handleSaveNickname()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarHidden(true)
    }
}

#Preview {
    let coordinator = SignInCoordinator()
    let client = NicknameClient.testValue
    let viewModel = NicknameViewModel(
        validateNickname: client.validateNickname,
        saveNickname: client.saveNickname,
        coordinator: coordinator
    )
    NavigationStack {
        NicknameView(viewModel: viewModel)
    }
}
