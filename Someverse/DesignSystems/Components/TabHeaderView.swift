//
//  TabHeaderView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct TabHeaderView<TrailingContent: View>: View {
  let trailingContent: TrailingContent?
  var backgroundColor: Color = .white
  
  init(
    backgroundColor: Color = .white,
    @ViewBuilder trailingContent: () -> TrailingContent
  ) {
    self.backgroundColor = backgroundColor
    self.trailingContent = trailingContent()
  }
  
  var body: some View {
    HStack {
      Text("SOMEVERSE")
        .font(.someverseBodyRegular)
        .fontWeight(.bold)
        .foregroundColor(.someversePrimary)
      
      Spacer()
      
      trailingContent
    }
    .font(.someverseHeadline)
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
    .background(backgroundColor)
  }
}

extension TabHeaderView where TrailingContent == EmptyView {
  init(backgroundColor: Color = .white) {
    self.backgroundColor = backgroundColor
    self.trailingContent = nil
  }
}

#Preview {
  VStack(spacing: 0) {
    TabHeaderView()
    
    TabHeaderView(backgroundColor: .someverseBackground) {
      HStack(spacing: 16) {
        Button("포인트") {}
          .font(.someverseBodyRegular)
          .foregroundColor(.someverseTextSecondary)
        
        Text("|")
          .foregroundColor(.someverseInactive)
        
        Button("설정") {}
          .font(.someverseBodyRegular)
          .foregroundColor(.someverseTextSecondary)
      }
    }
  }
}
