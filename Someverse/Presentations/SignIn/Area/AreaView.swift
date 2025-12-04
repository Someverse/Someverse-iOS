//
//  AreaView.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct AreaView: View {
    @State private var selectedAreas: [Area] = []
    @State private var navigateToProfileImage = false

    private var isAreaSelected: Bool {
        !selectedAreas.isEmpty
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
                Text("주 활동 지역을 알려주세요.")
                    .font(.someverseHeadline)
                    .foregroundColor(.black)

                Text("최대 2개 지역까지 선택할 수 있어요!")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 24)

            // Area Picker
            AreaPicker(selectedAreas: $selectedAreas)
                .padding(.horizontal, 24)

            // Selected Areas
            if !selectedAreas.isEmpty {
                HStack(spacing: 8) {
                    ForEach(selectedAreas) { area in
                        SelectedAreaChip(area: area) {
                            removeArea(area)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)
            }

            Spacer()

            // Page Indicator
            PageIndicator(totalPages: 5, currentPage: 3)
                .padding(.bottom, 16)

            // CTA Button
            CTAButton(
                title: "선택했어요!",
                isEnabled: isAreaSelected
            ) {
                handleAreaSelection()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToProfileImage) {
            ProfileImageView()
        }
    }

    private func removeArea(_ area: Area) {
        selectedAreas.removeAll { $0.id == area.id }
    }

    private func handleAreaSelection() {
        print("선택된 지역: \(selectedAreas.map { $0.displayName }.joined(separator: ", "))")
        navigateToProfileImage = true
    }
}

#Preview {
    AreaView()
}
