//
//  FileDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - File Upload Response

struct FileUploadResponse: Decodable {
  let urls: [String]

  enum CodingKeys: String, CodingKey {
    case urls
  }
}

// MARK: - Single File Upload Response

struct SingleFileUploadResponse: Decodable {
  let url: String
  let fileName: String?
  let fileSize: Int?
  let mimeType: String?

  enum CodingKeys: String, CodingKey {
    case url
    case fileName
    case fileSize
    case mimeType
  }
}

// MARK: - Presigned URL Request

struct PresignedURLRequest: Encodable {
  let fileName: String
  let contentType: String
  let directory: String?

  enum CodingKeys: String, CodingKey {
    case fileName
    case contentType
    case directory
  }
}

// MARK: - Presigned URL Response

struct PresignedURLResponse: Decodable {
  let uploadUrl: String
  let fileUrl: String
  let expiresAt: String

  enum CodingKeys: String, CodingKey {
    case uploadUrl
    case fileUrl
    case expiresAt
  }
}

// MARK: - Multiple Presigned URL Request

struct MultiplePresignedURLRequest: Encodable {
  let files: [FileInfoRequest]

  enum CodingKeys: String, CodingKey {
    case files
  }
}

struct FileInfoRequest: Encodable {
  let fileName: String
  let contentType: String

  enum CodingKeys: String, CodingKey {
    case fileName
    case contentType
  }
}

// MARK: - Multiple Presigned URL Response

struct MultiplePresignedURLResponse: Decodable {
  let urls: [PresignedURLInfo]

  enum CodingKeys: String, CodingKey {
    case urls
  }
}

struct PresignedURLInfo: Decodable {
  let uploadUrl: String
  let fileUrl: String
  let fileName: String
  let expiresAt: String

  enum CodingKeys: String, CodingKey {
    case uploadUrl
    case fileUrl
    case fileName
    case expiresAt
  }
}
