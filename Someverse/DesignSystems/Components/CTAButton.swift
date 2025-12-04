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
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    Group {
                        if isEnabled {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 119/255, green: 82/255, blue: 254/255),
                                    Color(red: 255/255, green: 130/255, blue: 171/255)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        } else {
                            Color(red: 200/255, green: 200/255, blue: 200/255)
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
