//
//  SignInView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

struct SignInView: View {
  @StateObject private var viewModel: SignInViewModel
  
  init(nicknameViewModel: NicknameViewModel, dateHelper: DateProviding = DateHelper.shared) {
    _viewModel = StateObject(wrappedValue: SignInViewModel(
      nicknameViewModel: nicknameViewModel,
      dateHelper: dateHelper
    ))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(
        title: "회원가입",
        showBackButton: viewModel.currentPage.previous != nil
      ) {
        viewModel.navigateToPreviousPage()
      }
      
      pageContent
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
        .transition(.asymmetric(
          insertion: .move(edge: .trailing),
          removal: .move(edge: .leading)
        ))
      
      PageIndicator(totalPages: SignInPage.totalPages, currentPage: viewModel.currentPage.rawValue)
        .padding(.bottom, 16)
      
      CTAButton(
        title: viewModel.currentPage.ctaTitle,
        isEnabled: viewModel.isPageValid
      ) {
        viewModel.navigateToNextPage()
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 40)
    }
    .navigationBarHidden(true)
    .navigationDestination(isPresented: $viewModel.navigateToApproval) {
      ApprovalPendingView()
    }
  }
}

// MARK: - Page Content
private extension SignInView {
  @ViewBuilder
  var pageContent: some View {
    switch viewModel.currentPage {
    case .nickname:
      NicknamePageView(viewModel: viewModel.nicknameViewModel)
    case .gender:
      GenderPageView(selectedGender: $viewModel.formData.gender)
    case .birthday:
      BirthdayPageView(
        selectedYear: $viewModel.formData.birthDate.year,
        selectedMonth: $viewModel.formData.birthDate.month,
        selectedDay: $viewModel.formData.birthDate.day
      )
    case .area:
      AreaPageView(selectedAreas: $viewModel.formData.areas)
    case .profileImage:
      ProfileImagePageView(images: $viewModel.formData.images)
    case .genre:
      GenrePageView(selectedGenres: $viewModel.formData.genres)
    case .favoriteMovie:
      FavoriteMoviePageView(selectedMovies: $viewModel.formData.movies)
    }
  }
}

#Preview {
  let client = NicknameClient.testValue
  let viewModel = NicknameViewModel(
    validateNickname: client.validateNickname,
    saveNickname: client.saveNickname
  )
  return NavigationStack {
    SignInView(nicknameViewModel: viewModel)
  }
}
