//
//  MyView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct MyView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        Text("마이")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.white)
      .navigationTitle("마이")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  MyView()
}
