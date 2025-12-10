//
//  ImagePlaceholder.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import SwiftUI

struct ImagePlaceholder: View {
  let width: CGFloat
  let height: CGFloat
  var cornerRadius: CGFloat = 8

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .fill(Color.someverseInactive.opacity(0.3))
      .frame(width: width, height: height)
  }
}

// MARK: - Aspect Ratio Placeholder
struct AspectRatioPlaceholder: View {
  let aspectRatio: CGFloat
  var cornerRadius: CGFloat = 8

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .fill(Color.someverseInactive.opacity(0.3))
      .aspectRatio(aspectRatio, contentMode: .fit)
  }
}

#Preview {
  VStack(spacing: 20) {
    ImagePlaceholder(width: 60, height: 80)
    ImagePlaceholder(width: 50, height: 50)
    AspectRatioPlaceholder(aspectRatio: 0.7)
      .frame(width: 80)
  }
  .padding()
}
