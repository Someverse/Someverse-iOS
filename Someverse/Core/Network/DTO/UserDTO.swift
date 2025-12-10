//
//  UserDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Common Models

struct LocationDTO: Codable {
  let city: String
  let district: String

  enum CodingKeys: String, CodingKey {
    case city
    case district
  }
}

// MARK: - User Me Response

struct UserMeResponse: Decodable {
  let userId: Int
  let email: String?
  let provider: String
  let isOnboardingCompleted: Bool
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case email
    case provider
    case isOnboardingCompleted
    case createdAt
  }
}

// MARK: - Onboarding Status Response

struct OnboardingStatusResponse: Decodable {
  let userId: Int
  let currentStep: String
  let completedSteps: [String]
  let isCompleted: Bool

  enum CodingKeys: String, CodingKey {
    case userId
    case currentStep
    case completedSteps
    case isCompleted
  }
}

// MARK: - Terms Agree

struct TermsAgreeRequest: Encodable {
  let termsAgreements: [TermsAgreementItem]

  enum CodingKeys: String, CodingKey {
    case termsAgreements
  }
}

struct TermsAgreementItem: Codable {
  let termsId: Int
  let agreed: Bool

  enum CodingKeys: String, CodingKey {
    case termsId
    case agreed
  }
}

struct TermsAgreeResponse: Decodable {
  let userId: Int
  let agreedTerms: [Int]
  let agreedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case agreedTerms
    case agreedAt
  }
}

// MARK: - Basic Info

struct BasicInfoRequest: Encodable {
  let nickName: String
  let realName: String
  let gender: String
  let birthDate: String
  let phone: String
  let email: String?

  enum CodingKeys: String, CodingKey {
    case nickName
    case realName
    case gender
    case birthDate
    case phone
    case email
  }
}

struct BasicInfoResponse: Decodable {
  let userId: Int
  let nickName: String
  let realName: String
  let gender: String
  let birthDate: String
  let age: Int
  let phone: String
  let email: String?

  enum CodingKeys: String, CodingKey {
    case userId
    case nickName
    case realName
    case gender
    case birthDate
    case age
    case phone
    case email
  }
}

// MARK: - Location

struct LocationRequest: Encodable {
  let locations: [LocationDTO]

  enum CodingKeys: String, CodingKey {
    case locations
  }
}

struct LocationResponse: Decodable {
  let userId: Int
  let locations: [LocationDTO]

  enum CodingKeys: String, CodingKey {
    case userId
    case locations
  }
}

// MARK: - Profile Images

struct ProfileImagesRequest: Encodable {
  let imageUrls: [String]

  enum CodingKeys: String, CodingKey {
    case imageUrls
  }
}

struct ProfileImagesResponse: Decodable {
  let userId: Int
  let profileImages: [ProfileImageDTO]

  enum CodingKeys: String, CodingKey {
    case userId
    case profileImages
  }
}

struct ProfileImageDTO: Decodable {
  let imageId: Int
  let imageUrl: String
  let orderIndex: Int
  let isPrimary: Bool

  enum CodingKeys: String, CodingKey {
    case imageId
    case imageUrl
    case orderIndex
    case isPrimary
  }
}

// MARK: - Genre Select

struct GenreSelectRequest: Encodable {
  let genreIds: [Int]

  enum CodingKeys: String, CodingKey {
    case genreIds
  }
}

struct GenreSelectResponse: Decodable {
  let userId: Int
  let selectedGenres: [SelectedGenreDTO]

  enum CodingKeys: String, CodingKey {
    case userId
    case selectedGenres
  }
}

struct SelectedGenreDTO: Decodable {
  let genreId: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case genreId
    case name
  }
}

// MARK: - Movie Select

struct MovieSelectRequest: Encodable {
  let movieIds: [Int]

  enum CodingKeys: String, CodingKey {
    case movieIds
  }
}

struct MovieSelectResponse: Decodable {
  let userId: Int
  let selectedMovies: [SelectedMovieDTO]

  enum CodingKeys: String, CodingKey {
    case userId
    case selectedMovies
  }
}

struct SelectedMovieDTO: Decodable {
  let movieId: Int
  let title: String
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case movieId
    case title
    case posterPath
  }
}

// MARK: - Onboarding Complete

struct OnboardingCompleteResponse: Decodable {
  let userId: Int
  let isCompleted: Bool
  let completedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case isCompleted
    case completedAt
  }
}

// MARK: - User Profile Response

struct UserProfileResponse: Decodable {
  let userId: Int
  let nickName: String
  let realName: String?
  let gender: String
  let birthDate: String
  let age: Int
  let bio: String?
  let job: String?
  let phone: String?
  let email: String?
  let locations: [LocationDTO]
  let profileImages: [ProfileImageDTO]
  let selectedGenres: [SelectedGenreDTO]
  let selectedMovies: [SelectedMovieDTO]
  let isOnboardingCompleted: Bool
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case nickName
    case realName
    case gender
    case birthDate
    case age
    case bio
    case job
    case phone
    case email
    case locations
    case profileImages
    case selectedGenres
    case selectedMovies
    case isOnboardingCompleted
    case createdAt
    case updatedAt
  }
}

// MARK: - Nickname Check

struct NicknameCheckResponse: Decodable {
  let nickname: String
  let isAvailable: Bool
  let reason: String?

  enum CodingKeys: String, CodingKey {
    case nickname
    case isAvailable
    case reason
  }
}

// MARK: - Profile Update Requests

struct BioUpdateRequest: Encodable {
  let bio: String

  enum CodingKeys: String, CodingKey {
    case bio
  }
}

struct JobUpdateRequest: Encodable {
  let job: String

  enum CodingKeys: String, CodingKey {
    case job
  }
}

struct PhoneUpdateRequest: Encodable {
  let phone: String

  enum CodingKeys: String, CodingKey {
    case phone
  }
}

struct NicknameUpdateRequest: Encodable {
  let nickName: String

  enum CodingKeys: String, CodingKey {
    case nickName
  }
}

// MARK: - Matching Filter

struct MatchingFilterRequest: Encodable {
  let minAge: Int
  let maxAge: Int
  let genderPreference: String
  let maxDistance: Int?
  let preferredGenreIds: [Int]?

  enum CodingKeys: String, CodingKey {
    case minAge
    case maxAge
    case genderPreference
    case maxDistance
    case preferredGenreIds
  }
}

struct MatchingFilterResponse: Decodable {
  let userId: Int
  let minAge: Int
  let maxAge: Int
  let genderPreference: String
  let maxDistance: Int?
  let preferredGenreIds: [Int]?
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case minAge
    case maxAge
    case genderPreference
    case maxDistance
    case preferredGenreIds
    case updatedAt
  }
}

// MARK: - Theme Preferences

struct ThemePreferencesRequest: Encodable {
  let isDarkMode: Bool
  let fontSize: String
  let language: String

  enum CodingKeys: String, CodingKey {
    case isDarkMode
    case fontSize
    case language
  }
}

struct ThemePreferencesResponse: Decodable {
  let userId: Int
  let isDarkMode: Bool
  let fontSize: String
  let language: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case isDarkMode
    case fontSize
    case language
    case updatedAt
  }
}

// MARK: - Notification Settings

struct NotificationSettingsRequest: Encodable {
  let pushEnabled: Bool
  let matchingNotification: Bool
  let chatNotification: Bool
  let marketingNotification: Bool

  enum CodingKeys: String, CodingKey {
    case pushEnabled
    case matchingNotification
    case chatNotification
    case marketingNotification
  }
}

struct NotificationSettingsResponse: Decodable {
  let userId: Int
  let pushEnabled: Bool
  let matchingNotification: Bool
  let chatNotification: Bool
  let marketingNotification: Bool
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case userId
    case pushEnabled
    case matchingNotification
    case chatNotification
    case marketingNotification
    case updatedAt
  }
}

// MARK: - Account Deletion

struct AccountDeletionResponse: Decodable {
  let userId: Int
  let deletedAt: String
  let message: String

  enum CodingKeys: String, CodingKey {
    case userId
    case deletedAt
    case message
  }
}

// MARK: - Legacy DTOs (Router 호환용)

struct SignUpRequestDTO: Encodable {
  let nickName: String
  let realName: String
  let gender: String
  let birthDate: String
  let phone: String
  let email: String?
  let locations: [LocationDTO]
  let genreIds: [Int]
  let movieIds: [Int]
  let imageUrls: [String]?

  enum CodingKeys: String, CodingKey {
    case nickName
    case realName
    case gender
    case birthDate
    case phone
    case email
    case locations
    case genreIds
    case movieIds
    case imageUrls
  }
}

struct ProfileUpdateRequestDTO: Encodable {
  let nickName: String?
  let bio: String?
  let job: String?
  let locations: [LocationDTO]?
  let genreIds: [Int]?
  let movieIds: [Int]?
  let imageUrls: [String]?

  enum CodingKeys: String, CodingKey {
    case nickName
    case bio
    case job
    case locations
    case genreIds
    case movieIds
    case imageUrls
  }
}
