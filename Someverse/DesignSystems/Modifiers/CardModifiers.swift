//
//  CardModifiers.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import SwiftUI

// MARK: - Card Style Modifier
extension View {
  /// 기본 카드 스타일 (padding: 16, background: secondary, cornerRadius: 12)
  func cardStyle() -> some View {
    self
      .padding(16)
      .background(Color.someverseBackgroundSecondary)
      .cornerRadius(12)
  }

  /// 프라이머리 카드 스타일 (padding: 24, background: white, cornerRadius: 24, shadow)
  func primaryCardStyle() -> some View {
    self
      .padding(24)
      .background(Color.someverseBackgroundWhite)
      .cornerRadius(24)
      .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
  }

  /// 피드 카드 스타일 (padding: 20, background: white, cornerRadius: 20, shadow)
  func feedCardStyle() -> some View {
    self
      .padding(20)
      .background(Color.someverseBackgroundWhite)
      .cornerRadius(20)
      .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
  }
}
