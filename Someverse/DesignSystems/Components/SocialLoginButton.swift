import SwiftUI

// MARK: - Kakao Login Button (Design Guide Compliant)
struct KakaoLoginButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image.kakaoSymbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)

                Text("카카오 로그인")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black.opacity(0.85))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.someverseKakao)
            .cornerRadius(12)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        KakaoLoginButton {
            print("Kakao login tapped")
        }
    }
    .padding()
}
