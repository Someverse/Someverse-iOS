import SwiftUI

enum SocialLoginType {
    case kakao
    case apple

    var backgroundColor: Color {
        switch self {
        case .kakao:
            return Color(red: 254/255, green: 229/255, blue: 0/255)
        case .apple:
            return Color(red: 230/255, green: 232/255, blue: 240/255)
        }
    }

    var iconName: String {
        switch self {
        case .kakao:
            return "bubble.left.fill"
        case .apple:
            return "apple.logo"
        }
    }

    var title: String {
        switch self {
        case .kakao:
            return "카카오 로그인"
        case .apple:
            return "애플 회원가입/로그인"
        }
    }

    var foregroundColor: Color {
        switch self {
        case .kakao:
            return .black
        case .apple:
            return .black
        }
    }
}

struct SocialLoginButton: View {
    let type: SocialLoginType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: type.iconName)
                    .font(.system(size: 18, weight: .medium))

                Text(type.title)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(type.foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(type.backgroundColor)
            .cornerRadius(12)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        SocialLoginButton(type: .kakao) {
            print("Kakao login tapped")
        }

        SocialLoginButton(type: .apple) {
            print("Apple login tapped")
        }
    }
    .padding()
}
