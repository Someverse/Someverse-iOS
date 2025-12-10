//
//  Colors.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI

extension Color {
    // MARK: - Brand Colors
    static let someversePrimary = Color(red: 119/255, green: 82/255, blue: 254/255)
    static let someverseGradientEnd = Color(red: 255/255, green: 130/255, blue: 171/255)

    // MARK: - Text Colors
    static let someverseTextTitle = Color.black
    static let someverseTextPrimary = Color(red: 100/255, green: 100/255, blue: 100/255)
    static let someverseTextSecondary = Color(red: 130/255, green: 130/255, blue: 130/255)
    static let someverseTextTertiary = Color(red: 150/255, green: 150/255, blue: 150/255)
    static let someverseTextPlaceholder = Color(red: 158/255, green: 158/255, blue: 158/255)
    static let someverseTextWhite = Color.white

    // MARK: - Background Colors
    static let someverseBackground = Color(red: 240/255, green: 242/255, blue: 245/255)
    static let someverseBackgroundSecondary = Color(red: 245/255, green: 245/255, blue: 245/255)
    static let someverseBackgroundWhite = Color.white

    // MARK: - Overlay
    static let someverseOverlay = Color.black.opacity(0.5)

    // MARK: - State Colors
    static let someverseInactive = Color(red: 200/255, green: 200/255, blue: 200/255)
    static let someverseError = Color(red: 255/255, green: 71/255, blue: 71/255)
    static let someversePickerTint = Color(red: 114/255, green: 80/255, blue: 201/255, opacity: 0.3)

    // MARK: - Gender Colors
    static let someverseGenderMale = Color(red: 100/255, green: 181/255, blue: 246/255)
    static let someverseGenderFemale = Color(red: 244/255, green: 143/255, blue: 177/255)

    // MARK: - Social Login Colors
    static let someverseKakao = Color(red: 254/255, green: 229/255, blue: 0/255)
    static let someverseApple = Color(red: 230/255, green: 232/255, blue: 240/255)

    // MARK: - Chip Colors
    static let someverseChipActive = Color(red: 255/255, green: 107/255, blue: 107/255)
}

extension LinearGradient {
    static let someversePrimary = LinearGradient(
        gradient: Gradient(colors: [.someversePrimary, .someverseGradientEnd]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
