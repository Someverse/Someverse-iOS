//
//  ThemeCard.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct ThemeCard: View {
  let title: String
  let chips: [String]

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      CardHeaderView(title: title)

      FlowLayout(spacing: 8) {
        ForEach(chips, id: \.self) { chip in
          ChipView(text: chip, style: .outline)
        }
      }
    }
    .cardStyle()
  }
}

#Preview {
  VStack(spacing: 12) {
    ThemeCard(title: "좋아하는 분위기", chips: ["웅장한", "신나는", "희망적인"])
    ThemeCard(title: "좋아하는 서사", chips: ["첫사랑", "성장", "디스토피아"])
  }
  .padding()
}
