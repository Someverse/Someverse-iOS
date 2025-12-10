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
      HStack {
        Image.iconHeart
          .foregroundColor(.someversePrimary)
        
        Text("좋아하는 작품")
          .font(.someverseBody)
          .foregroundColor(.someversePrimary)
        
        Spacer()
        
        Button("편집", action: onEdit)
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }
      
      HStack(spacing: 8) {
        if works.isEmpty {
          ForEach(0..<placeholderCount, id: \.self) { _ in
            workPlaceholder
          }
        } else {
          ForEach(works.prefix(placeholderCount), id: \.self) { url in
            AsyncImage(url: url) { image in
              image
                .resizable()
                .scaledToFill()
            } placeholder: {
              workPlaceholder
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .aspectRatio(0.7, contentMode: .fit)
          }
        }
      }
    }
    .padding(16)
    .background(Color.someverseBackgroundSecondary)
    .cornerRadius(12)
  }
  
  private var workPlaceholder: some View {
    RoundedRectangle(cornerRadius: 8)
      .fill(Color.someverseInactive.opacity(0.3))
      .aspectRatio(0.7, contentMode: .fit)
  }
}

#Preview {
  VStack(spacing: 20) {
    FavoriteWorksCard(works: [], onEdit: {})
  }
  .padding()
}
