//
//  NetworkManager.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

final class NetworkManager {
  static let shared = NetworkManager()
  
  private let session: URLSession
  private let middleware: NetworkMiddleware
  private let tokenManager: TokenManager
  private var isRefreshing = false
  
  private init(
    session: URLSession = .shared,
    middleware: NetworkMiddleware = NetworkMiddleware(),
    tokenManager: TokenManager = .shared
  ) {
    self.session = session
    self.middleware = middleware
    self.tokenManager = tokenManager
  }
  
  // MARK: - Generic Request
  
  func request<T: Decodable>(_ router: APIRouter, type: T.Type) async throws -> T {
    var urlRequest = try router.asURLRequest()
    middleware.prepare(request: &urlRequest, authorizationType: router.authorizationType)
    
#if DEBUG
    logRequest(urlRequest)
#endif
    
    do {
      let (data, response) = try await session.data(for: urlRequest)
      
#if DEBUG
      logResponse(data: data, response: response)
#endif
      
      let processedData = try middleware.handleResponse(data: data, response: response)
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return try decoder.decode(T.self, from: processedData)
      
    } catch let error as NetworkError {
      // 토큰 만료 시 자동 갱신
      if error == .accessTokenExpired || error == .unauthorized {
        return try await handleTokenRefresh(router: router, type: type)
      }
      throw error
    } catch is DecodingError {
      throw NetworkError.decodingFailed
    } catch {
      throw NetworkError.requestFailed
    }
  }
  
  // MARK: - Request without Response Body
  
  func requestWithoutResponse(_ router: APIRouter) async throws {
    var urlRequest = try router.asURLRequest()
    middleware.prepare(request: &urlRequest, authorizationType: router.authorizationType)
    
#if DEBUG
    logRequest(urlRequest)
#endif
    
    do {
      let (data, response) = try await session.data(for: urlRequest)
      
#if DEBUG
      logResponse(data: data, response: response)
#endif
      
      _ = try middleware.handleResponse(data: data, response: response)
      
    } catch let error as NetworkError {
      if error == .accessTokenExpired || error == .unauthorized {
        try await handleTokenRefreshWithoutResponse(router: router)
        return
      }
      throw error
    } catch {
      throw NetworkError.requestFailed
    }
  }
  
  // MARK: - Image Upload (Multipart)
  
  func uploadImage(_ router: APIRouter, imageData: Data, fieldName: String = "image") async throws -> Data {
    var urlRequest = try router.asURLRequest()
    middleware.prepare(request: &urlRequest, authorizationType: router.authorizationType)
    
    let boundary = "Boundary-\(UUID().uuidString)"
    urlRequest.setValue(
      "multipart/form-data; boundary=\(boundary)",
      forHTTPHeaderField: APIConstants.Header.contentType
    )
    
    var body = Data()
    
    // 이미지 데이터 추가
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    urlRequest.httpBody = body
    
#if DEBUG
    print("NetworkManager: 이미지 업로드 시작 - 크기: \(imageData.count) bytes")
#endif
    
    let (data, response) = try await session.data(for: urlRequest)
    return try middleware.handleResponse(data: data, response: response)
  }
  
  // MARK: - Multiple Images Upload
  
  func uploadMultipleImages(_ router: APIRouter, images: [Data], fieldName: String = "images") async throws -> Data {
    var urlRequest = try router.asURLRequest()
    middleware.prepare(request: &urlRequest, authorizationType: router.authorizationType)
    
    let boundary = "Boundary-\(UUID().uuidString)"
    urlRequest.setValue(
      "multipart/form-data; boundary=\(boundary)",
      forHTTPHeaderField: APIConstants.Header.contentType
    )
    
    var body = Data()
    
    for (index, imageData) in images.enumerated() {
      body.append("--\(boundary)\r\n".data(using: .utf8)!)
      body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
      body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
      body.append(imageData)
      body.append("\r\n".data(using: .utf8)!)
    }
    
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    urlRequest.httpBody = body
    
#if DEBUG
    print("NetworkManager: 다중 이미지 업로드 시작 - 개수: \(images.count)")
#endif
    
    let (data, response) = try await session.data(for: urlRequest)
    return try middleware.handleResponse(data: data, response: response)
  }
  
  // MARK: - Token Refresh
  
  private func handleTokenRefresh<T: Decodable>(router: APIRouter, type: T.Type) async throws -> T {
    guard !isRefreshing else {
      throw NetworkError.refreshTokenExpired
    }
    
    isRefreshing = true
    defer { isRefreshing = false }
    
    guard tokenManager.refreshToken != nil else {
      tokenManager.clearAll()
      throw NetworkError.refreshTokenExpired
    }
    
#if DEBUG
    print("NetworkManager: 토큰 갱신 시작")
#endif
    
    // 토큰 갱신 요청
    let refreshRouter = AuthRouter.refreshToken
    let tokenResponse = try await request(refreshRouter, type: TokenResponse.self)
    
    // 새 토큰 저장
    tokenManager.saveTokens(
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken
    )
    
#if DEBUG
    print("NetworkManager: 토큰 갱신 완료")
#endif
    
    // 원래 요청 재시도
    return try await request(router, type: type)
  }
  
  private func handleTokenRefreshWithoutResponse(router: APIRouter) async throws {
    guard !isRefreshing else {
      throw NetworkError.refreshTokenExpired
    }
    
    isRefreshing = true
    defer { isRefreshing = false }
    
    guard tokenManager.refreshToken != nil else {
      tokenManager.clearAll()
      throw NetworkError.refreshTokenExpired
    }
    
    let refreshRouter = AuthRouter.refreshToken
    let tokenResponse = try await request(refreshRouter, type: TokenResponse.self)
    
    tokenManager.saveTokens(
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken
    )
    
    try await requestWithoutResponse(router)
  }
  
  // MARK: - Logging
  
#if DEBUG
  private func logRequest(_ request: URLRequest) {
    print("========== Network Request ==========")
    print("[\(request.httpMethod ?? "UNKNOWN")] \(request.url?.absoluteString ?? "")")
    print("Headers: \(request.allHTTPHeaderFields ?? [:])")
    if let body = request.httpBody,
       let bodyString = String(data: body, encoding: .utf8) {
      print("Body: \(bodyString)")
    }
    print("======================================")
  }
  
  private func logResponse(data: Data, response: URLResponse?) {
    print("========== Network Response ==========")
    if let httpResponse = response as? HTTPURLResponse {
      print("Status Code: \(httpResponse.statusCode)")
    }
    if let dataString = String(data: data, encoding: .utf8) {
      let truncated = dataString.prefix(500)
      print("Data: \(truncated)\(dataString.count > 500 ? "..." : "")")
    }
    print("======================================")
  }
#endif
}

// MARK: - Token Response (임시, AuthDTO로 이동 예정)

struct TokenResponse: Decodable {
  let accessToken: String
  let refreshToken: String
}
