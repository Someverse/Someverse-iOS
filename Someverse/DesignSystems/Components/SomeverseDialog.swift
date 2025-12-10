//
//  SomeverseDialog.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct SomeverseDialog: View {
    let title: String
    var message: String? = nil
    let leftButtonTitle: String
    let rightButtonTitle: String
    let onLeftButtonTapped: () -> Void
    let onRightButtonTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.someverseHeadline)
                    .foregroundColor(.someverseTextTitle)

                if let message = message {
                    Text(message)
                        .font(.someverseBodyRegular)
                        .foregroundColor(.someverseTextSecondary)
                        .multilineTextAlignment(.center)
                }
            }

            HStack(spacing: 12) {
                Button(action: onLeftButtonTapped) {
                    Text(leftButtonTitle)
                        .font(.someverseBody)
                        .foregroundColor(.someverseTextSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.someverseBackgroundSecondary)
                        .cornerRadius(12)
                }

                Button(action: onRightButtonTapped) {
                    Text(rightButtonTitle)
                        .font(.someverseBody)
                        .foregroundColor(.someverseTextWhite)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.someverseChipActive)
                        .cornerRadius(12)
                }
            }
        }
        .padding(24)
        .background(Color.someverseBackgroundWhite)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

// MARK: - View Modifier for Dialog Presentation
struct SomeverseDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    var message: String? = nil
    let leftButtonTitle: String
    let rightButtonTitle: String
    let onLeftButtonTapped: () -> Void
    let onRightButtonTapped: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.someverseOverlay
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }

                SomeverseDialog(
                    title: title,
                    message: message,
                    leftButtonTitle: leftButtonTitle,
                    rightButtonTitle: rightButtonTitle,
                    onLeftButtonTapped: {
                        isPresented = false
                        onLeftButtonTapped()
                    },
                    onRightButtonTapped: {
                        isPresented = false
                        onRightButtonTapped()
                    }
                )
                .padding(.horizontal, 40)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
}

extension View {
    func someverseDialog(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        leftButtonTitle: String,
        rightButtonTitle: String,
        onLeftButtonTapped: @escaping () -> Void = {},
        onRightButtonTapped: @escaping () -> Void = {}
    ) -> some View {
        modifier(SomeverseDialogModifier(
            isPresented: isPresented,
            title: title,
            message: message,
            leftButtonTitle: leftButtonTitle,
            rightButtonTitle: rightButtonTitle,
            onLeftButtonTapped: onLeftButtonTapped,
            onRightButtonTapped: onRightButtonTapped
        ))
    }
}

#Preview {
    VStack(spacing: 40) {
        SomeverseDialog(
            title: "정말 로그아웃 하시겠어요?",
            leftButtonTitle: "취소",
            rightButtonTitle: "로그아웃",
            onLeftButtonTapped: {},
            onRightButtonTapped: {}
        )

        SomeverseDialog(
            title: "정말 탈퇴하시겠어요?",
            message: "프로필 정보 및 작성 피드가 즉시 비노출되며,\n탈퇴 이후 30일간 재가입이 불가능합니다.",
            leftButtonTitle: "취소",
            rightButtonTitle: "탈퇴하기",
            onLeftButtonTapped: {},
            onRightButtonTapped: {}
        )
    }
    .padding()
    .background(Color.someverseBackground)
}
