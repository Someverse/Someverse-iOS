//
//  ChatView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct ChatView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        Text("채팅")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.white)
      .navigationTitle("채팅")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ChatView()
}
