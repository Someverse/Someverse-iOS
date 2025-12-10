//
//  MatchingCardView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct MatchingCardView: View {
  let profile: MatchingProfile
  var onReport: (() -> Void)?

  var body: some View {
    VStack(spacing: 20) {
      headerSection
      profileImageSection
      locationSection
      genreSection
    }
    .primaryCardStyle()
  }

  // MARK: - Header Section View
  private var headerSection: some View {
    HStack {
      Spacer()

      Text("\(profile.nickname), \(profile.age)세")
        .font(.someverseHeadline)
        .foregroundColor(.someverseTextTitle)

      ReportButton(onReport: onReport)

      Spacer()
    }
  }

  // MARK: - Profile Image Section View
  private var profileImageSection: some View {
    ProfileImageView(imageURL: profile.imageURL, size: 200)
  }

  // MARK: - Location Section View
  private var locationSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 4) {
        Image.iconLocation
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)
          .foregroundColor(.someverseTextSecondary)

        Text("위치")
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }

      HStack(spacing: 8) {
        ForEach(profile.locations, id: \.self) { location in
          LocationChip(text: location, isPrimary: location == profile.locations.first)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: - Genre Section View
  private var genreSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 4) {
        Image.iconGenre
          .font(.someverseIconSmall)
          .foregroundColor(.someverseTextSecondary)

        Text("취향")
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
      }

      FlowLayout(spacing: 8) {
        ForEach(profile.genres, id: \.self) { genre in
          ChipView(text: genre, style: .genre)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  ZStack {
    Color.someverseBackground
      .ignoresSafeArea()

    MatchingCardView(
      profile: MatchingProfile(
        nickname: "마포구보안관2",
        age: 28,
        locations: ["서울특별시 성북구", "경기도 화성시"],
        genres: ["뮤지컬", "스릴러/범죄", "드라마", "코미디"]
      )
    )
    .padding(.horizontal, 20)
  }
}
