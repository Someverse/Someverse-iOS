//
//  SocialLoginModel.swift
//  Someverse
//
//  Created by 박채현 on 11/28/25.
//

import Foundation

struct SocialLoginModel: Equatable, Sendable {
    let token: String

    static let mock = SocialLoginModel(token: "mock")
}
