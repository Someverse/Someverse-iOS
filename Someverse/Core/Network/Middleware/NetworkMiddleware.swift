//
//  NetworkMiddleware.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

final class NetworkMiddleware {
  
  private let tokenManager: TokenManager
  
  init(tokenManager: TokenManager = .shared) {
    self.tokenManager = tokenManager
  }
  
  // MARK: - Request Preparation
  
  func prepare(request: inout URLRequest, authorizationType: AuthorizationType) {
    switch authorizationType {
    case .none:
      break
      
    case .apiKey:
      // API 키 설정 (필요시 구현)
      // request.setValue(APIKeys.someverse, forHTTPHeaderField: APIConstants.Header.apiKey)
      break
      
    case .accessToken:
      if let token = tokenManager.accessToken {
        request.setValue("Bearer \(token)", forHTTPHeaderField: APIConstants.Header.authorization)
      }
      
    case .refreshToken:
      if let token = tokenManager.refreshToken {
        request.setValue(token, forHTTPHeaderField: APIConstants.Header.refreshToken)
      }
      if let accessToken = tokenManager.accessToken {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: APIConstants.Header.authorization)
      }
      
    case .both:
      // API 키 + 액세스 토큰
      // request.setValue(APIKeys.someverse, forHTTPHeaderField: APIConstants.Header.apiKey)
      if let token = tokenManager.accessToken {
        request.setValue("Bearer \(token)", forHTTPHeaderField: APIConstants.Header.authorization)
      }
    }
  }
  
  // MARK: - Response Handling
  
  func handleResponse(data: Data?, response: URLResponse?) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.invalidResponse
    }
    
    guard let data = data else {
      throw NetworkError.emptyData
    }
    
#if DEBUG
    print("NetworkMiddleware: 상태 코드 - \(httpResponse.statusCode)")
#endif
    
    switch httpResponse.statusCode {
    case 200...299:
      return data
      
    case 400:
      // 요청 바디에서 에러 메시지 파싱 시도
      if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
        throw NetworkError.customError(errorResponse.message)
      }
      throw NetworkError.badRequest
      
    case 401:
      throw NetworkError.unauthorized
      
    case 403:
      throw NetworkError.forbidden
      
    case 404:
      throw NetworkError.notFound
      
    case 409:
      // 충돌 (예: 닉네임 중복)
      throw NetworkError.conflict
      
    case 418:
      // 리프레시 토큰 만료 (커스텀)
      throw NetworkError.refreshTokenExpired
      
    case 419:
      // 액세스 토큰 만료 (커스텀)
      throw NetworkError.accessTokenExpired
      
    case 429:
      throw NetworkError.tooManyRequests
      
    case 500...599:
      throw NetworkError.serverError
      
    default:
      throw NetworkError.invalidStatusCode(httpResponse.statusCode)
    }
  }
}

// MARK: - Error Response Model

struct ErrorResponse: Decodable {
  let message: String
  let code: String?
  
  enum CodingKeys: String, CodingKey {
    case message
    case code
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decode(String.self, forKey: .message)
    code = try container.decodeIfPresent(String.self, forKey: .code)
  }
}
