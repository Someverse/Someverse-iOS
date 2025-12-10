//
//  CurationCard.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct CurationCard: View {
  let title: String
  let chips: [String]
  let onEdit: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Image.iconHeart
          .foregroundColor(.someversePrimary)
        
        Text(title)
          .font(.someverseBody)
          .foregroundColor(.someversePrimary)
        
        Spacer()
        
        Button("편집", action: onEdit)
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }
      
      FlowLayout(spacing: 8) {
        ForEach(chips, id: \.self) { chip in
          ChipView(text: chip, style: .outline)
        }
      }
    }
    .padding(16)
    .background(Color.someverseBackgroundSecondary)
    .cornerRadius(12)
  }
}

#Preview {
  CurationCard(
    title: "좋아하는 장르",
    chips: ["뮤지컬", "공포/호러", "SF", "애니메이션"],
    onEdit: {}
  )
  .padding()
}
