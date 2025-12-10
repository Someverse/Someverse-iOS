//
//  NetworkRouter.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - APIRouter Protocol

protocol APIRouter {
  var path: String { get }
  var method: HTTPMethod { get }
  var contentType: String { get }
  var body: Data? { get }
  var queryItems: [URLQueryItem]? { get }
  var authorizationType: AuthorizationType { get }
}

// MARK: - HTTP Method

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

// MARK: - Authorization Type

enum AuthorizationType {
  case none              // 인증 불필요
  case apiKey            // API 키만
  case accessToken       // 액세스 토큰
  case refreshToken      // 리프레시 토큰
  case both              // API 키 + 액세스 토큰
}

// MARK: - APIRouter Default Implementation

extension APIRouter {
  
  var baseURL: URL? {
    URL(string: APIConstants.baseURL)
  }
  
  var contentType: String {
    APIConstants.ContentType.json
  }
  
  var queryItems: [URLQueryItem]? {
    nil
  }
  
  func asURLRequest() throws -> URLRequest {
    guard let baseURL = baseURL else {
      throw NetworkError.invalidURL
    }
    
    var urlComponents = URLComponents(
      url: baseURL.appendingPathComponent(path),
      resolvingAgainstBaseURL: true
    )
    urlComponents?.queryItems = queryItems
    
    guard let url = urlComponents?.url else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setValue(contentType, forHTTPHeaderField: APIConstants.Header.contentType)
    
    if let body = body {
      request.httpBody = body
    }
    
    return request
  }
}
