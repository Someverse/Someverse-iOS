import SwiftUI

enum Gender: String, CaseIterable {
    case male = "남성"
    case female = "여성"

    var icon: String {
        switch self {
        case .male:
            return "♂"
        case .female:
            return "♀"
        }
    }

    var color: Color {
        switch self {
        case .male:
            return Color(red: 100/255, green: 181/255, blue: 246/255)
        case .female:
            return Color(red: 244/255, green: 143/255, blue: 177/255)
        }
    }
}

struct GenderSelectionButton: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                ZStack {
                    if isSelected {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 119/255, green: 82/255, blue: 254/255),
                                        Color(red: 255/255, green: 130/255, blue: 171/255)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                            .frame(width: 88, height: 88)
                    }

                    Text(gender.icon)
                        .font(.system(size: 48))
                        .foregroundColor(gender.color)
                }
                .frame(width: 88, height: 88)

                Text(gender.rawValue)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}

struct GenderSelection: View {
    @Binding var selectedGender: Gender?

    var body: some View {
        HStack(spacing: 40) {
            ForEach(Gender.allCases, id: \.self) { gender in
                GenderSelectionButton(
                    gender: gender,
                    isSelected: selectedGender == gender
                ) {
                    selectedGender = gender
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        GenderSelection(selectedGender: .constant(nil))

        GenderSelection(selectedGender: .constant(.male))

        GenderSelection(selectedGender: .constant(.female))
    }
    .padding()
}
