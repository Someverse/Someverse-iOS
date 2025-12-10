//
//  CardHeaderView.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import SwiftUI

struct CardHeaderView: View {
  let title: String
  var showEditButton: Bool = false
  var onEdit: (() -> Void)?

  var body: some View {
    HStack {
      Image.iconHeart
        .foregroundColor(.someversePrimary)

      Text(title)
        .font(.someverseBody)
        .foregroundColor(.someversePrimary)

      Spacer()

      if showEditButton, let onEdit = onEdit {
        Button("편집", action: onEdit)
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }
    }
  }
}

#Preview {
  VStack(spacing: 20) {
    CardHeaderView(title: "좋아하는 장르")

    CardHeaderView(title: "좋아하는 장르", showEditButton: true) {
      print("Edit tapped")
    }
  }
  .padding()
}
