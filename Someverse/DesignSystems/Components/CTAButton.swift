import SwiftUI

struct CTAButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.someverseButton)
                .foregroundColor(.someverseTextWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    Group {
                        if isEnabled {
                            LinearGradient.someversePrimary
                        } else {
                            Color.someverseInactive
                        }
                    }
                )
                .cornerRadius(12)
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        CTAButton(title: "닉네임 결정하기", isEnabled: true) {
            print("CTA button tapped")
        }

        CTAButton(title: "닉네임 결정하기", isEnabled: false) {
            print("CTA button tapped")
        }
    }
    .padding()
}
