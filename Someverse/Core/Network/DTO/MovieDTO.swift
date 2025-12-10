//
//  MovieDTO.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import Foundation

// MARK: - Movie DTO

struct MovieDTO: Decodable {
  let id: Int
  let tmdbId: Int
  let title: String
  let originalTitle: String?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let runtime: Int?
  let voteAverage: Double?
  let voteCount: Int?
  let popularity: Double?
  let genres: [GenreDTO]?
  let adult: Bool?

  enum CodingKeys: String, CodingKey {
    case id
    case tmdbId
    case title
    case originalTitle
    case overview
    case posterPath
    case backdropPath
    case releaseDate
    case runtime
    case voteAverage
    case voteCount
    case popularity
    case genres
    case adult
  }
}

// MARK: - Movie List Response

struct MovieListResponse: Decodable {
  let movies: [MovieDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case movies
    case pageInfo
  }
}

// MARK: - Movie Search Response

struct MovieSearchResponse: Decodable {
  let results: [MovieSearchResultDTO]
  let totalResults: Int
  let totalPages: Int
  let page: Int

  enum CodingKeys: String, CodingKey {
    case results
    case totalResults
    case totalPages
    case page
  }
}

struct MovieSearchResultDTO: Decodable {
  let id: Int
  let title: String
  let originalTitle: String?
  let overview: String?
  let posterPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  let popularity: Double?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case originalTitle
    case overview
    case posterPath
    case releaseDate
    case voteAverage
    case popularity
  }
}

// MARK: - Movie Detail Response

struct MovieDetailResponse: Decodable {
  let id: Int
  let tmdbId: Int
  let title: String
  let originalTitle: String?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let runtime: Int?
  let voteAverage: Double?
  let voteCount: Int?
  let popularity: Double?
  let genres: [GenreDTO]
  let cast: [CastDTO]?
  let crew: [CrewDTO]?
  let videos: [VideoDTO]?
  let adult: Bool

  enum CodingKeys: String, CodingKey {
    case id
    case tmdbId
    case title
    case originalTitle
    case overview
    case posterPath
    case backdropPath
    case releaseDate
    case runtime
    case voteAverage
    case voteCount
    case popularity
    case genres
    case cast
    case crew
    case videos
    case adult
  }
}

// MARK: - Cast & Crew DTO

struct CastDTO: Decodable {
  let id: Int
  let name: String
  let character: String?
  let profilePath: String?
  let order: Int?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case character
    case profilePath
    case order
  }
}

struct CrewDTO: Decodable {
  let id: Int
  let name: String
  let job: String
  let department: String?
  let profilePath: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case job
    case department
    case profilePath
  }
}

// MARK: - Video DTO

struct VideoDTO: Decodable {
  let id: String
  let key: String
  let name: String
  let site: String
  let type: String

  enum CodingKeys: String, CodingKey {
    case id
    case key
    case name
    case site
    case type
  }
}

// MARK: - Onboarding Movie Response

struct OnboardingMovieResponse: Decodable {
  let movies: [OnboardingMovieDTO]

  enum CodingKeys: String, CodingKey {
    case movies
  }
}

struct OnboardingMovieDTO: Decodable {
  let id: Int
  let title: String
  let posterPath: String?
  let releaseYear: Int?
  let genreIds: [Int]?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath
    case releaseYear
    case genreIds
  }
}

// MARK: - Popular Movies Response

struct PopularMoviesResponse: Decodable {
  let movies: [MovieDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case movies
    case pageInfo
  }
}

// MARK: - Movies By Genre Response

struct MoviesByGenreResponse: Decodable {
  let genreId: Int
  let genreName: String
  let movies: [MovieDTO]
  let pageInfo: PageInfo?

  enum CodingKeys: String, CodingKey {
    case genreId
    case genreName
    case movies
    case pageInfo
  }
}
