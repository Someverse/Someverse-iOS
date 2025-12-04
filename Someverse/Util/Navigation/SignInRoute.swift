//
//  SignInRoute.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import Foundation

enum SignInRoute: Hashable {
    case nickname
    case gender
    case birthday
    case area
    case profileImage
    case taste
    case approval
}

enum SignInStep: Int, CaseIterable {
    case nickname = 0
    case gender = 1
    case birthday = 2
    case area = 3
    case profileImage = 4

    var totalSteps: Int {
        Self.allCases.count
    }
}
