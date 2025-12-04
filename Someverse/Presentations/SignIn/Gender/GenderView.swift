//
//  GenderView.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct GenderView: View {
    @State private var selectedGender: Gender? = nil
    @State private var navigateToBirthday = false

    private var isGenderSelected: Bool {
        selectedGender != nil
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("회원가입")
                .font(.someverseBody)
                .foregroundColor(.someverseTextPrimary)
                .padding(.top, 20)

            Spacer()
                .frame(height: 60)

            // Title
            Text("성별을 알려주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)

            Spacer()
                .frame(height: 60)

            // Gender Selection
            GenderSelection(selectedGender: $selectedGender)

            Spacer()

            // Page Indicator
            PageIndicator(totalPages: 5, currentPage: 1)
                .padding(.bottom, 16)

            // CTA Button
            CTAButton(
                title: "선택했어요",
                isEnabled: isGenderSelected
            ) {
                handleGenderSelection()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToBirthday) {
            BirthdayView()
        }
    }

    private func handleGenderSelection() {
        guard let gender = selectedGender else { return }
        print("선택된 성별: \(gender.rawValue)")
        navigateToBirthday = true
    }
}

#Preview {
    GenderView()
}
