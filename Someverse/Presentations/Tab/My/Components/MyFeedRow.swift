//
//  MyFeedRow.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct MyFeedRow: View {
  let feed: MyFeed
  var onMoreTapped: (() -> Void)?
  
  var body: some View {
    HStack(spacing: 12) {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.someverseInactive.opacity(0.3))
        .frame(width: 50, height: 50)
      
      VStack(alignment: .leading, spacing: 4) {
        HStack(spacing: 4) {
          Text(feed.movieTitle)
            .font(.someverseBody)
            .foregroundColor(.someverseTextTitle)
          
          Text("(\(feed.year))")
            .font(.someverseCaption)
            .foregroundColor(.someverseTextSecondary)
        }
        
        Text(feed.comment)
          .font(.someverseBodyRegular)
          .foregroundColor(.someverseTextSecondary)
          .lineLimit(1)
      }
      
      Spacer()
      
      Button {
        onMoreTapped?()
      } label: {
        Image.iconMore
          .foregroundColor(.someverseTextSecondary)
      }
    }
    .padding(16)
    .background(Color.someverseBackgroundSecondary)
    .cornerRadius(12)
  }
}

#Preview {
  MyFeedRow(
    feed: MyFeed(
      movieTitle: "인셉션",
      year: "2010",
      comment: "꿈 속의 꿈, 정말 대단한 영화였어요"
    )
  )
  .padding()
}
