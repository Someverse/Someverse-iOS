//
//  EmptyStateView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct EmptyStateView: View {
  let infoTitle: String
  let subText: String

  var body: some View {
    VStack(spacing: 8) {
      Text(infoTitle)
        .font(.someverseHeadline)
        .foregroundColor(.someverseTextTitle)
        .multilineTextAlignment(.center)

      Text(subText)
        .font(.someverseBodyRegular)
        .foregroundColor(.someverseTextSecondary)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  EmptyStateView(
    infoTitle: "아직 채팅이 없어요",
    subText: "매칭이 성사되면 채팅을 시작할 수 있어요"
  )
}
