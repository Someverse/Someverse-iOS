//
//  Colors.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI

extension Color {
    // 실제 사용되는 색상만 정의
    static let someversePrimary = Color(red: 119/255, green: 82/255, blue: 254/255)
    static let someverseGradientEnd = Color(red: 255/255, green: 130/255, blue: 171/255)
    static let someverseTextPrimary = Color(red: 100/255, green: 100/255, blue: 100/255)
    static let someverseTextSecondary = Color(red: 130/255, green: 130/255, blue: 130/255)
    static let someverseTextTertiary = Color(red: 150/255, green: 150/255, blue: 150/255)
    static let someverseInactive = Color(red: 200/255, green: 200/255, blue: 200/255)
    static let someverseBackground = Color(red: 240/255, green: 242/255, blue: 245/255)
    static let someverseError = Color(red: 255/255, green: 71/255, blue: 71/255)
}

extension LinearGradient {
    static let someversePrimary = LinearGradient(
        gradient: Gradient(colors: [.someversePrimary, .someverseGradientEnd]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
