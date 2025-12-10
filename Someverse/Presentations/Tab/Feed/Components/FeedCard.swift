//
//  FeedCard.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct FeedCard: View {
  let feed: Feed
  var onReport: (() -> Void)?

  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 16) {
        HStack(alignment: .top, spacing: 12) {
          moviePosterView

          VStack(alignment: .leading, spacing: 4) {
            Text(feed.movieTitle)
              .font(.someverseHeadline)
              .foregroundColor(.someverseTextTitle)

            Text("(\(feed.movieYear))")
              .font(.someverseBodyRegular)
              .foregroundColor(.someverseTextSecondary)
          }

          Spacer()

          ReportButton(onReport: onReport)
        }

        commentBadge

        Text(feed.comment)
          .font(.someverseBodyMedium)
          .foregroundColor(.someverseTextTitle)
          .multilineTextAlignment(.center)
          .lineLimit(3)
          .frame(maxWidth: .infinity)
      }
      .feedCardStyle()

      Triangle()
        .fill(Color.someverseBackgroundWhite)
        .frame(width: 20, height: 12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

      ProfileImageView(imageURL: feed.authorProfileImageURL, size: 72)
        .padding(.top, 8)
    }
  }

  // MARK: - Movie Poster View
  private var moviePosterView: some View {
    ImagePlaceholder(width: 60, height: 80)
      .overlay {
        if let imageURL = feed.movieImageURL {
          AsyncImage(url: imageURL) { image in
            image
              .resizable()
              .scaledToFill()
          } placeholder: {
            Color.someverseInactive.opacity(0.3)
          }
          .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }
  }

  // MARK: - Comment Badge View
  private var commentBadge: some View {
    HStack(spacing: 6) {
      Image.iconHeart
        .font(.someverseIconSmall)
        .foregroundColor(.someverseGradientEnd)

      Text("\(feed.authorNickname) 님의 코멘트")
        .font(.someverseBody)
        .foregroundColor(.someversePrimary)

      Spacer()
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background(Color.someverseGradientEnd.opacity(0.1))
    .cornerRadius(20)
  }
}

#Preview {
  FeedCard(
    feed: Feed(
      movieTitle: "어쩔수가없다",
      movieYear: "2025",
      authorNickname: "마포구보안관2",
      comment: "박찬욱 영화중 제일 웃기지만\n다소 불친절하다."
    )
  )
  .padding(.horizontal, 40)
}
