//
//  NavigationBar.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

struct NavigationBar: View {
    let title: String
    let showBackButton: Bool
    let onBack: (() -> Void)?

    init(title: String, showBackButton: Bool = false, onBack: (() -> Void)? = nil) {
        self.title = title
        self.showBackButton = showBackButton
        self.onBack = onBack
    }

    var body: some View {
        HStack {
            if showBackButton, let onBack = onBack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.someverseIcon)
                        .foregroundColor(.someverseTextTitle)
                }
            } else {
                Spacer()
                    .frame(width: 20)
            }

            Spacer()

            Text(title)
                .font(.someverseBody)
                .foregroundColor(.someverseTextPrimary)

            Spacer()

            Spacer()
                .frame(width: 20)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

#Preview {
    VStack(spacing: 20) {
        NavigationBar(title: "회원가입")

        NavigationBar(title: "회원가입", showBackButton: true) {
            print("Back tapped")
        }
    }
}
