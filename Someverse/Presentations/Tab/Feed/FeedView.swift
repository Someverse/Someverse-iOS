//
//  FeedView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct FeedView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        Text("피드")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.white)
      .navigationTitle("피드")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  FeedView()
}
