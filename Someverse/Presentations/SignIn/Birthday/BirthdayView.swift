//
//  BirthdayView.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct BirthdayView: View {
    @State private var selectedYear: Int = 1991
    @State private var selectedMonth: Int = 4
    @State private var selectedDay: Int = 4
    @State private var navigateToArea = false

    private var age: Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        return currentYear - selectedYear
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
            Text("생년월일을 알려주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)

            Spacer()
                .frame(height: 40)

            // Birthday Picker
            BirthdayPicker(
                selectedYear: $selectedYear,
                selectedMonth: $selectedMonth,
                selectedDay: $selectedDay
            )
            .padding(.horizontal, 24)

            // Age Display
            Text("만 \(age)세")
                .font(.someverseBodyRegular)
                .foregroundColor(.someverseTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 8)

            Spacer()

            // Page Indicator
            PageIndicator(totalPages: 5, currentPage: 2)
                .padding(.bottom, 16)

            // CTA Button
            CTAButton(
                title: "선택했어요",
                isEnabled: true
            ) {
                handleBirthdaySelection()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToArea) {
            AreaView()
        }
    }

    private func handleBirthdaySelection() {
        print("선택된 생년월일: \(selectedYear)년 \(selectedMonth)월 \(selectedDay)일 (만 \(age)세)")
        navigateToArea = true
    }
}

#Preview {
    BirthdayView()
}
