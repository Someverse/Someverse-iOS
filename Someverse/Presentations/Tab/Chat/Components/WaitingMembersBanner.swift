//
//  WaitingMembersBanner.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct WaitingMembersBanner: View {
  let waiting: WaitingMembers
  var onTap: (() -> Void)?

  var body: some View {
    HStack(spacing: 12) {
      Circle()
        .fill(Color.someversePrimary.opacity(0.2))
        .frame(width: 48, height: 48)
        .overlay {
          Image.tabProfile
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(.someversePrimary)
        }

      VStack(alignment: .leading, spacing: 2) {
        Text("대기 중인 회원들")
          .font(.someverseBody)
          .foregroundColor(.someverseTextTitle)

        Text("인사를 기다리는 회원들이 있어요!")
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }

      Spacer()

      VStack(alignment: .trailing, spacing: 2) {
        Text(waiting.formattedCount)
          .font(.someverseSmallBold)
          .foregroundColor(.someversePrimary)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(Color.someversePrimary.opacity(0.15))
          .cornerRadius(10)

        Text(waiting.formattedTime)
          .font(.someverseCaption)
          .foregroundColor(.someverseTextTertiary)
      }
    }
    .padding(16)
    .background(Color.someversePrimary.opacity(0.08))
    .cornerRadius(12)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(Color.someversePrimary.opacity(0.3), lineWidth: 1)
    )
    .onTapGesture {
      onTap?()
    }
  }
}

#Preview {
  WaitingMembersBanner(
    waiting: WaitingMembers(count: 99, lastUpdated: Date().addingTimeInterval(-120))
  )
  .padding()
}
