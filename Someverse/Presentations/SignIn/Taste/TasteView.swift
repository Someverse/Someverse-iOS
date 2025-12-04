//
//  TasteView.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct TasteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedGenres: [MovieGenre] = []
    @State private var navigateToApproval = false

    private let maxSelections = 5

    private var isGenresSelected: Bool {
        !selectedGenres.isEmpty
    }

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

                Text("취향 입력")
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
                Text("어떤 장르의 영화를\n좋아하세요?")
                    .font(.someverseTitle)
                    .foregroundColor(.black)
                    .lineSpacing(4)

                Text("최대 5개까지 고를 수 있어요!")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 60)

            // Genre Selection
            TasteChipGrid(selectedGenres: $selectedGenres, maxSelections: maxSelections)
                .padding(.horizontal, 24)

            Spacer()

            // CTA Button
            CTAButton(
                title: "인생영화 고르기",
                isEnabled: isGenresSelected
            ) {
                handleGenreSelection()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToApproval) {
            ApprovalPendingView()
        }
    }

    private func handleGenreSelection() {
        print("선택된 장르: \(selectedGenres.map { $0.name }.joined(separator: ", "))")
        navigateToApproval = true
    }
}

#Preview {
    TasteView()
}
