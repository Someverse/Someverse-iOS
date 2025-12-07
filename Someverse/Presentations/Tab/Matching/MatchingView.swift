//
//  MatchingView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct MatchingView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        Text("매칭")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.white)
      .navigationTitle("매칭")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  MatchingView()
}
