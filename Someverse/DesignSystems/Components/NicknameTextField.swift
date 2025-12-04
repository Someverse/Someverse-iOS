import SwiftUI

enum NicknameValidationState: Equatable {
    case idle
    case error(String)
    case success(String)

    var messageColor: Color {
        switch self {
        case .idle:
            return .clear
        case .error:
            return Color(red: 255/255, green: 71/255, blue: 71/255)
        case .success:
            return Color(red: 100/255, green: 100/255, blue: 100/255)
        }
    }

    var message: String {
        switch self {
        case .idle:
            return ""
        case .error(let msg):
            return msg
        case .success(let msg):
            return msg
        }
    }

    var textColor: Color? {
        switch self {
        case .idle:
            return nil
        case .error:
            return Color(red: 255/255, green: 71/255, blue: 71/255)
        case .success:
            return .black
        }
    }
}

struct NicknameTextField: View {
    @Binding var text: String
    let placeholder: String
    let validationState: NicknameValidationState

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 158/255, green: 158/255, blue: 158/255))

                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .foregroundColor(validationState.textColor ?? .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(red: 240/255, green: 242/255, blue: 245/255))
            .cornerRadius(8)

            if !validationState.message.isEmpty {
                Text(validationState.message)
                    .font(.system(size: 14))
                    .foregroundColor(validationState.messageColor)
                    .padding(.leading, 4)
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        NicknameTextField(
            text: .constant(""),
            placeholder: "닉네임을 입력하세요",
            validationState: .idle
        )

        NicknameTextField(
            text: .constant("미운구보만"),
            placeholder: "닉네임을 입력하세요",
            validationState: .error("이미 사용하고 있는 닉네임입니다.")
        )

        NicknameTextField(
            text: .constant("미쳤구보만2"),
            placeholder: "닉네임을 입력하세요",
            validationState: .success("사용 가능한 닉네임입니다.")
        )
    }
    .padding()
}
