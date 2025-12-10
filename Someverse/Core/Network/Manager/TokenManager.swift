//
//  TokenManager.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation
import Security
import Combine

// MARK: - Token Manager

final class TokenManager: ObservableObject {
  static let shared = TokenManager()
  
  private let service = Bundle.main.bundleIdentifier ?? "com.someverse.app"
  private let accessTokenKey = "SomeverseAccessToken"
  private let refreshTokenKey = "SomeverseRefreshToken"
  
  private init() {}
  
  // MARK: - Token Properties
  
  var accessToken: String? {
    get { getValue(forKey: accessTokenKey) }
    set {
      if let newValue = newValue {
        setValue(newValue, forKey: accessTokenKey)
      } else {
        deleteValue(forKey: accessTokenKey)
      }
    }
  }
  
  var refreshToken: String? {
    get { getValue(forKey: refreshTokenKey) }
    set {
      if let newValue = newValue {
        setValue(newValue, forKey: refreshTokenKey)
      } else {
        deleteValue(forKey: refreshTokenKey)
      }
    }
  }
  
  // MARK: - Token Management
  
  func saveTokens(accessToken: String, refreshToken: String) {
#if DEBUG
    print("TokenManager: 토큰 저장 시작")
#endif
    self.accessToken = accessToken
    self.refreshToken = refreshToken
#if DEBUG
    print("TokenManager: 토큰 저장 완료")
#endif
  }
  
  func clearTokens() {
#if DEBUG
    print("TokenManager: 토큰 삭제 시작")
#endif
    accessToken = nil
    refreshToken = nil
#if DEBUG
    print("TokenManager: 토큰 삭제 완료")
#endif
  }
  
  func hasValidTokens() -> Bool {
    let hasTokens = accessToken != nil && refreshToken != nil
#if DEBUG
    print("TokenManager: 토큰 존재 여부 - \(hasTokens)")
#endif
    return hasTokens
  }
  
  // MARK: - Keychain Helper Methods
  
  private func setValue(_ value: String, forKey key: String) {
    let data = Data(value.utf8)
    
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: key,
      kSecValueData as String: data
    ]
    
    // 기존 항목 삭제
    SecItemDelete(query as CFDictionary)
    
    // 새 항목 추가
    let status = SecItemAdd(query as CFDictionary, nil)
#if DEBUG
    if status != errSecSuccess {
      print("Keychain 저장 실패 (\(key)): \(status)")
    } else {
      print("Keychain 저장 성공 (\(key))")
    }
#endif
  }
  
  private func getValue(forKey key: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    guard status == errSecSuccess,
          let data = item as? Data,
          let value = String(data: data, encoding: .utf8) else {
#if DEBUG
      if status == errSecItemNotFound {
        print("Keychain: \(key) 데이터 없음")
      } else if status != errSecSuccess {
        print("Keychain 조회 실패 (\(key)): \(status)")
      }
#endif
      return nil
    }
    return value
  }
  
  private func deleteValue(forKey key: String) {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: key
    ]
    
    let status = SecItemDelete(query as CFDictionary)
#if DEBUG
    if status != errSecSuccess && status != errSecItemNotFound {
      print("Keychain 삭제 실패 (\(key)): \(status)")
    } else {
      print("Keychain 삭제 성공 (\(key))")
    }
#endif
  }
}

// MARK: - User Info (JWT 디코딩 없이 서버에서 받은 정보 저장)

extension TokenManager {
  private static let userIdKey = "SomeverseUserId"
  
  var userId: String? {
    get { getValue(forKey: Self.userIdKey) }
    set {
      if let newValue = newValue {
        setValue(newValue, forKey: Self.userIdKey)
      } else {
        deleteValue(forKey: Self.userIdKey)
      }
    }
  }
  
  func saveUserInfo(userId: String) {
    self.userId = userId
  }
  
  func clearUserInfo() {
    userId = nil
  }
  
  func clearAll() {
    clearTokens()
    clearUserInfo()
  }
}
