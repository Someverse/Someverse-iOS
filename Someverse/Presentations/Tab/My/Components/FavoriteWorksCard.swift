//
//  FavoriteWorksCard.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct FavoriteWorksCard: View {
  let works: [URL]
  let onEdit: () -> Void

  private let placeholderCount = 4

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      CardHeaderView(title: "좋아하는 작품", showEditButton: true, onEdit: onEdit)

      HStack(spacing: 8) {
        if works.isEmpty {
          ForEach(0..<placeholderCount, id: \.self) { _ in
            AspectRatioPlaceholder(aspectRatio: 0.7)
          }
        } else {
          ForEach(works.prefix(placeholderCount), id: \.self) { url in
            AsyncImage(url: url) { image in
              image
                .resizable()
                .scaledToFill()
            } placeholder: {
              AspectRatioPlaceholder(aspectRatio: 0.7)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .aspectRatio(0.7, contentMode: .fit)
          }
        }
      }
    }
    .cardStyle()
  }
}

#Preview {
  VStack(spacing: 20) {
    FavoriteWorksCard(works: [], onEdit: {})
  }
  .padding()
}
