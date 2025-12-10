//
//  ProfileImageView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct ProfileImageView: View {
  let imageURL: URL?
  let size: CGFloat
  var placeholderIconSize: CGFloat? = nil
  var strokeGradient: Bool = false

  private var iconSize: CGFloat {
    placeholderIconSize ?? size * 0.5
  }

  var body: some View {
    Circle()
      .fill(Color.someverseInactive.opacity(0.3))
      .frame(width: size, height: size)
      .overlay {
        if let imageURL {
          AsyncImage(url: imageURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            placeholderIcon
          }
          .clipShape(Circle())
        } else {
          placeholderIcon
        }
      }
      .overlay {
        if strokeGradient {
          Circle()
            .stroke(LinearGradient.someversePrimary, lineWidth: 2)
        }
      }
  }

  private var placeholderIcon: some View {
    Image.tabProfile
      .resizable()
      .scaledToFit()
      .frame(width: iconSize, height: iconSize)
      .foregroundColor(.someverseInactive)
  }
}

#Preview {
  VStack(spacing: 20) {
    ProfileImageView(imageURL: nil, size: 100)
    ProfileImageView(imageURL: nil, size: 72, strokeGradient: true)
    ProfileImageView(imageURL: nil, size: 48)
  }
}
