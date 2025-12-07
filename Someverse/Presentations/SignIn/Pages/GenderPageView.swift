//
//  GenderPageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

// MARK: - Gender Model
enum Gender: String, CaseIterable {
    case male = "남성"
    case female = "여성"

    var icon: String {
        switch self {
        case .male: return "♂"
        case .female: return "♀"
        }
    }

    var color: Color {
        switch self {
        case .male: return .someverseGenderMale
        case .female: return .someverseGenderFemale
        }
    }
}

// MARK: - Gender Page View
struct GenderPageView: View {
    @Binding var selectedGender: Gender?

    var body: some View {
        VStack(spacing: 0) {
            Text("성별을 알려주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.someverseTextTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)

            Spacer()
                .frame(height: 60)

            genderSelection
        }
    }
}

// MARK: - Gender Selection
private extension GenderPageView {
    var genderSelection: some View {
        HStack(spacing: 40) {
            ForEach(Gender.allCases, id: \.self) { gender in
                genderButton(for: gender)
            }
        }
    }

    func genderButton(for gender: Gender) -> some View {
        Button(action: {
            selectedGender = gender
        }) {
            VStack(spacing: 16) {
                ZStack {
                    if selectedGender == gender {
                        Circle()
                            .stroke(
                                LinearGradient.someversePrimary,
                                lineWidth: 3
                            )
                            .frame(width: 88, height: 88)
                    }

                    Text(gender.icon)
                        .font(.someverseIconXLarge)
                        .foregroundColor(gender.color)
                }
                .frame(width: 88, height: 88)

                Text(gender.rawValue)
                    .font(.someverseBodyMedium)
                    .foregroundColor(.someverseTextTitle)
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        GenderPageView(selectedGender: .constant(nil))
        GenderPageView(selectedGender: .constant(.male))
    }
    .padding()
}
