//
//  NetworkError.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

enum NetworkError: Error, Equatable {
  
  // MARK: - Network Basic Errors
  
  case invalidURL
  case requestFailed
  case invalidResponse
  case decodingFailed
  case encodingFailed
  case emptyData
  case unknownError
  case customError(String)
  
  // MARK: - HTTP Status Code Errors
  
  case badRequest              // 400
  case unauthorized            // 401
  case forbidden               // 403
  case notFound                // 404
  case conflict                // 409
  case accessTokenExpired      // 419
  case refreshTokenExpired     // 418
  case tooManyRequests         // 429
  case serverError             // 500+
  case invalidStatusCode(Int)
  
  // MARK: - Business Logic Errors
  
  case duplicateNickname
  case invalidNickname
  case registrationFailed
  case loginFailed
  
  // MARK: - Equatable
  
  static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    switch (lhs, rhs) {
    case (.invalidURL, .invalidURL),
      (.requestFailed, .requestFailed),
      (.invalidResponse, .invalidResponse),
      (.decodingFailed, .decodingFailed),
      (.encodingFailed, .encodingFailed),
      (.emptyData, .emptyData),
      (.unknownError, .unknownError),
      (.badRequest, .badRequest),
      (.unauthorized, .unauthorized),
      (.forbidden, .forbidden),
      (.notFound, .notFound),
      (.conflict, .conflict),
      (.accessTokenExpired, .accessTokenExpired),
      (.refreshTokenExpired, .refreshTokenExpired),
      (.tooManyRequests, .tooManyRequests),
      (.serverError, .serverError),
      (.duplicateNickname, .duplicateNickname),
      (.invalidNickname, .invalidNickname),
      (.registrationFailed, .registrationFailed),
      (.loginFailed, .loginFailed):
      return true
    case (.customError(let lhsMsg), .customError(let rhsMsg)):
      return lhsMsg == rhsMsg
    case (.invalidStatusCode(let lhsCode), .invalidStatusCode(let rhsCode)):
      return lhsCode == rhsCode
    default:
      return false
    }
  }
  
  // MARK: - Error Message
  
  var errorMessage: String {
    switch self {
    case .invalidURL:
      return "유효하지 않은 URL입니다."
    case .requestFailed:
      return "요청에 실패했습니다."
    case .invalidResponse:
      return "유효하지 않은 응답입니다."
    case .decodingFailed:
      return "데이터 디코딩에 실패했습니다."
    case .encodingFailed:
      return "데이터 인코딩에 실패했습니다."
    case .emptyData:
      return "데이터가 비어있습니다."
    case .unknownError:
      return "알 수 없는 오류가 발생했습니다."
    case .customError(let message):
      return message
    case .badRequest:
      return "잘못된 요청입니다."
    case .unauthorized:
      return "인증이 필요합니다."
    case .forbidden:
      return "접근 권한이 없습니다."
    case .notFound:
      return "요청한 리소스를 찾을 수 없습니다."
    case .conflict:
      return "충돌이 발생했습니다."
    case .accessTokenExpired:
      return "액세스 토큰이 만료되었습니다."
    case .refreshTokenExpired:
      return "세션이 만료되었습니다. 다시 로그인해주세요."
    case .tooManyRequests:
      return "요청이 너무 많습니다. 잠시 후 다시 시도해주세요."
    case .serverError:
      return "서버 오류가 발생했습니다."
    case .invalidStatusCode(let code):
      return "서버 오류: \(code)"
    case .duplicateNickname:
      return "이미 사용 중인 닉네임입니다."
    case .invalidNickname:
      return "사용할 수 없는 닉네임입니다."
    case .registrationFailed:
      return "회원가입에 실패했습니다."
    case .loginFailed:
      return "로그인에 실패했습니다."
    }
  }
}
