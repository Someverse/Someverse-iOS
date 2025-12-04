//
//  ApprovalPendingView.swift
//  Someverse
//
//  Created by 박채현 on 12/3/25.
//

import SwiftUI

struct ApprovalPendingView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }

                Spacer()

                Text("승인대기")
                    .font(.someverseBody)
                    .foregroundColor(.someverseTextPrimary)

                Spacer()

                // Placeholder for alignment
                Image(systemName: "chevron.left")
                    .font(.system(size: 20))
                    .opacity(0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()
                .frame(height: 40)

            // Title
            VStack(alignment: .leading, spacing: 8) {
                Text("가입 승인\n대기 중이에요!")
                    .font(.someverseTitle)
                    .foregroundColor(.black)
                    .lineSpacing(4)

                Text("안전한 사용을 위해 회원님의 정보를 확인하고 있어요!")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
                    .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()

            // CTA Button (disabled state)
            CTAButton(
                title: "승인 전 기다려 주세요",
                isEnabled: false
            ) {
                // No action - button is disabled
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ApprovalPendingView()
}
