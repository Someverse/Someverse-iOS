//
//  MyView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct MyView: View {
  @StateObject private var viewModel = MyViewModel()

  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVStack(spacing: 0) {
          headerView
          profileSection
          myFeedSection
          tasteCurationSection
          tasteThemeSection
        }
      }
      .background(Color.someverseBackground)
    }
  }

  // MARK: - Header View
  private var headerView: some View {
    TabHeaderView {
      HStack(spacing: 16) {
        Button("포인트") {
          viewModel.viewPoints()
        }
        .font(.someverseBodyRegular)
        .foregroundColor(.someverseTextSecondary)

        Text("|")
          .foregroundColor(.someverseInactive)

        Button("설정") {
          viewModel.viewSettings()
        }
        .font(.someverseBodyRegular)
        .foregroundColor(.someverseTextSecondary)
      }
    }
  }

  // MARK: - Profile Section View
  private var profileSection: some View {
    VStack(spacing: 12) {
      ZStack(alignment: .bottom) {
        ProfileImageView(imageURL: viewModel.profile?.imageURL, size: 100)

        Button {
          viewModel.editProfile()
        } label: {
          Text("편집")
            .font(.someverseCaption)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(LinearGradient.someversePrimary)
            .cornerRadius(10)
        }
        .offset(y: 10)
      }
      .padding(.top, 20)

      if let profile = viewModel.profile {
        VStack(spacing: 4) {
          Text("\(profile.nickname), \(profile.age)세")
            .font(.someverseHeadline)
            .foregroundColor(.someverseTextTitle)

          Text(profile.regions.joined(separator: ", "))
            .font(.someverseBodyRegular)
            .foregroundColor(.someverseTextSecondary)
        }
        .padding(.top, 8)
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.bottom, 24)
    .background(Color.someverseBackgroundWhite)
  }

  // MARK: - My Feed Section View
  private var myFeedSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text("내 피드")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)

        Spacer()

        if viewModel.hasFeeds {
          Button {
            viewModel.viewMoreFeeds()
          } label: {
            HStack(spacing: 4) {
              Text("더보기")
                .font(.someverseCaption)
              Image.iconChevronRight
                .font(.someverseCaptionSmall)
            }
            .foregroundColor(.someverseTextSecondary)
          }
        }
      }

      if viewModel.hasFeeds {
        feedListView
      } else {
        emptyFeedView
      }
    }
    .padding(20)
    .background(Color.someverseBackgroundWhite)
    .padding(.top, 8)
  }

  private var emptyFeedView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("아직 작성한 피드가 없어요!\n피드를 작성해 볼까요?")
        .font(.someverseBodyRegular)
        .foregroundColor(.someverseTextSecondary)

      CTAButton(title: "피드 작성하기") {
        viewModel.createFeed()
      }
    }
  }

  private var feedListView: some View {
    VStack(spacing: 12) {
      ForEach(viewModel.displayFeeds) { feed in
        MyFeedRow(feed: feed)
      }
    }
  }

  // MARK: - Taste Curation Section View
  private var tasteCurationSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("취향 큐레이션")
        .font(.someverseHeadline)
        .foregroundColor(.someverseTextTitle)

      CurationCard(
        title: "좋아하는 장르",
        chips: viewModel.favoriteGenres,
        onEdit: { viewModel.editGenres() }
      )

      FavoriteWorksCard(
        works: viewModel.favoriteWorks,
        onEdit: { viewModel.editFavoriteWorks() }
      )
    }
    .padding(20)
    .background(Color.someverseBackgroundWhite)
    .padding(.top, 8)
  }

  // MARK: - Taste Theme Section View
  private var tasteThemeSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text("취향 테마")
          .font(.someverseHeadline)
          .foregroundColor(.someverseTextTitle)

        Spacer()

        if viewModel.hasTasteTheme {
          Button("편집") {
            viewModel.editTasteTheme()
          }
          .font(.someverseCaption)
          .foregroundColor(.someverseTextSecondary)
        }
      }

      if viewModel.hasTasteTheme, let theme = viewModel.tasteTheme {
        tasteThemeContent(theme: theme)
      } else {
        emptyTasteThemeView
      }
    }
    .padding(20)
    .background(Color.someverseBackgroundWhite)
    .padding(.top, 8)
    .padding(.bottom, 20)
  }

  private var emptyTasteThemeView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("아직 취향 테마를 입력하지 않았어요!\n취향을 입력해 볼까요?")
        .font(.someverseBodyRegular)
        .foregroundColor(.someverseTextSecondary)

      CTAButton(title: "취향테마 입력하기") {
        viewModel.editTasteTheme()
      }
    }
  }

  private func tasteThemeContent(theme: TasteTheme) -> some View {
    VStack(spacing: 12) {
      ThemeCard(title: "좋아하는 분위기", chips: theme.moods)
      ThemeCard(title: "좋아하는 서사", chips: theme.narratives)
      ThemeCard(title: "덕질 포인트", chips: theme.duckPoints)
      ThemeCard(title: "원하는 토론주제", chips: theme.discussionTopics)
    }
  }
}

#Preview("Empty") {
  MyView()
}

#Preview("With Data") {
  MyView()
}
