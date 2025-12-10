//
//  MatchingView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct MatchingView: View {
  @StateObject private var viewModel = MatchingViewModel()

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        TabHeaderView(backgroundColor: .someverseBackground)

        if viewModel.isEmpty {
          EmptyStateView(
            infoTitle: "매칭 가능한 회원이 없어요",
            subText: "새로운 회원이 등록되면 알려드릴게요"
          )
        } else {
          matchingListView
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.someverseBackground)
    }
  }

  // MARK: - Matching List View
  private var matchingListView: some View {
    ScrollView {
      VStack(spacing: 16) {
        ForEach(viewModel.displayProfiles) { profile in
          MatchingCardView(profile: profile)
            .onTapGesture {
              // 프로필 상세 보기 액션
            }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
    }
  }
}

#Preview("With Data") {
  MatchingView()
}

#Preview("Empty") {
  MatchingView()
}
