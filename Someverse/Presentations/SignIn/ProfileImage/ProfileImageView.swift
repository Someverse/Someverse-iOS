//
//  ProfileImageView.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct ProfileImageView: View {
    @State private var images: [UIImage?] = []
    @State private var navigateToTaste = false

    private var hasRequiredImage: Bool {
        !images.isEmpty
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
                Text("프로필 사진을 업로드해주세요.")
                    .font(.someverseHeadline)
                    .foregroundColor(.black)

                Text("최대 6장까지 등록할 수 있어요.")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 32)

            // Image Grid
            ProfileImageGrid(images: $images)
                .padding(.horizontal, 24)

            Spacer()

            // Page Indicator
            PageIndicator(totalPages: 5, currentPage: 4)
                .padding(.bottom, 16)

            // CTA Button
            CTAButton(
                title: "선택했어요",
                isEnabled: hasRequiredImage
            ) {
                handleImageSelection()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToTaste) {
            TasteView()
        }
    }

    private func handleImageSelection() {
        print("선택된 이미지 개수: \(images.count)")
        navigateToTaste = true
    }
}

#Preview {
    ProfileImageView()
}
