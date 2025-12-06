//
//  Typography.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI

extension Font {
    // MARK: - Heading
    static let someverseTitle = Font.system(size: 24, weight: .bold)
    static let someverseHeadline = Font.system(size: 20, weight: .bold)

    // MARK: - Body
    static let someverseBody = Font.system(size: 16, weight: .semibold)
    static let someverseBodyMedium = Font.system(size: 16, weight: .medium)
    static let someverseBodyRegular = Font.system(size: 14)

    // MARK: - Button
    static let someverseButton = Font.system(size: 18, weight: .semibold)
    static let someverseButtonMedium = Font.system(size: 18, weight: .medium)

    // MARK: - Caption & Small
    static let someverseCaption = Font.system(size: 12)
    static let someverseSmallBold = Font.system(size: 12, weight: .bold)

    // MARK: - Chip & Label
    static let someverseChip = Font.system(size: 14, weight: .medium)
    static let someverseLabel = Font.system(size: 14)

    // MARK: - Picker
    static let someversePicker = Font.system(size: 20)

    // MARK: - Icon
    static let someverseIcon = Font.system(size: 20)
    static let someverseIconLarge = Font.system(size: 24)
    static let someverseIconXLarge = Font.system(size: 48)
}
