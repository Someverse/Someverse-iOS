//
//  MatchingCardView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct MatchingCardView: View {
  let profile: MatchingProfile
  
  var body: some View {
    VStack(spacing: 20) {
      headerSection
      profileImageSection
      locationSection
      genreSection
    }
    .padding(24)
    .background(Color.someverseBackgroundWhite)
    .cornerRadius(24)
    .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
  }
  
  // MARK: - Header
  private var headerSection: some View {
    HStack {
      Spacer()
      
      Text("\(profile.nickname), \(profile.age)세")
        .font(.someverseHeadline)
        .foregroundColor(.someverseTextTitle)
      
      Button {
        // 신고 액션
      } label: {
        Image.iconBell
          .font(.someverseIconMedium)
          .foregroundColor(.someverseInactive)
      }
      
      Spacer()
    }
  }
  
  // MARK: - Profile Image
  private var profileImageSection: some View {
    ProfileImageView(imageURL: profile.imageURL, size: 200)
  }
  
  // MARK: - Location
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
  
  // MARK: - Genre
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
