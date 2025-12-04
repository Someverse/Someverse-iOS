//
//  Typography.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI

extension Font {
    // 실제 사용되는 폰트만 정의
    static let someverseTitle = Font.system(size: 24, weight: .bold)
    static let someverseHeadline = Font.system(size: 20, weight: .bold)
    static let someverseBody = Font.system(size: 16, weight: .semibold)
    static let someverseBodyRegular = Font.system(size: 14)
    static let someverseCaption = Font.system(size: 12)
}
