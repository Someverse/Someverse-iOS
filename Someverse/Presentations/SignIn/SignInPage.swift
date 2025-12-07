//
//  SignInPage.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import Foundation

enum SignInPage: Int, CaseIterable {
  case nickname = 0
  case gender = 1
  case birthday = 2
  case area = 3
  case profileImage = 4
  case genre = 5
  case favoriteMovie = 6
  
  var ctaTitle: String {
    switch self {
    case .nickname: return "닉네임 결정하기"
    case .gender: return "선택했어요"
    case .birthday: return "선택했어요"
    case .area: return "선택했어요!"
    case .profileImage: return "선택했어요"
    case .genre: return "인생영화 고르기"
    case .favoriteMovie: return "인생영화 선택완료"
    }
  }
  
  var isLastPage: Bool {
    self == .favoriteMovie
  }
  
  var next: SignInPage? {
    SignInPage(rawValue: rawValue + 1)
  }
  
  var previous: SignInPage? {
    SignInPage(rawValue: rawValue - 1)
  }
  
  static var totalPages: Int {
    SignInPage.allCases.count
  }
}
