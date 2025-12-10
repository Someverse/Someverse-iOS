//
//  FeedView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct FeedView: View {
  @StateObject private var viewModel = FeedViewModel()

  var body: some View {
    NavigationStack {
      ZStack(alignment: .topTrailing) {
        VStack(spacing: 0) {
          TabHeaderView(backgroundColor: .someverseBackground)

          if viewModel.isEmpty {
            EmptyStateView(
              infoTitle: "아직 피드가 없어요",
              subText: "첫 번째 피드를 작성해보세요"
            )
          } else {
            Spacer()

            feedCarouselSection

            Spacer()
              .frame(height: 40)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.someverseBackground)

        floatingAddButton
          .padding(.trailing, 20)
          .padding(.top, 60)
      }
    }
  }

  // MARK: - Floating Add Button View
  private var floatingAddButton: some View {
    Button {
      viewModel.createFeed()
    } label: {
      Image.iconPlus
        .font(.someverseIconLarge)
        .foregroundColor(.someverseTextWhite)
        .frame(width: 56, height: 56)
        .background(LinearGradient.someversePrimary)
        .clipShape(Circle())
        .shadow(color: .someversePrimary.opacity(0.3), radius: 8, x: 0, y: 4)
    }
  }

  // MARK: - Feed Carousel View
  private var feedCarouselSection: some View {
    TabView(selection: $viewModel.currentFeedIndex) {
      ForEach(viewModel.feeds.indices, id: \.self) { index in
        FeedCard(feed: viewModel.feeds[index])
          .padding(.horizontal, 40)
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(height: 420)
  }
}

#Preview("With Data") {
  FeedView()
}

#Preview("Empty") {
  FeedView()
}
