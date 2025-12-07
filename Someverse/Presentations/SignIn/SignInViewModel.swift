//
//  SignInViewModel.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI
import Combine

// MARK: - Sign Up Form Data
struct SignUpFormData {
  var gender: Gender?
  var birthDate: BirthDate
  var areas: [Area] = []
  var images: [UIImage?] = []
  var genres: [MovieGenre] = []
  var movies: [Movie] = []
  
  struct BirthDate {
    var year: Int
    var month: Int
    var day: Int
    
    init(
      year: Int = DateHelper.shared.currentYear,
      month: Int = DateHelper.shared.currentMonth,
      day: Int = DateHelper.shared.currentDay
    ) {
      self.year = year
      self.month = month
      self.day = day
    }
  }
  
  init(dateHelper: DateProviding = DateHelper.shared) {
    self.birthDate = BirthDate(
      year: dateHelper.currentYear,
      month: dateHelper.currentMonth,
      day: dateHelper.currentDay
    )
  }
}

// MARK: - Sign In ViewModel
@MainActor
final class SignInViewModel: ObservableObject {
  @Published var currentPage: SignInPage = .nickname
  @Published var formData: SignUpFormData
  @Published var navigateToApproval = false
  
  let nicknameViewModel: NicknameViewModel
  private var cancellables = Set<AnyCancellable>()
  
  init(
    nicknameViewModel: NicknameViewModel,
    dateHelper: DateProviding = DateHelper.shared
  ) {
    self.nicknameViewModel = nicknameViewModel
    self.formData = SignUpFormData(dateHelper: dateHelper)
    
    nicknameViewModel.objectWillChange
      .receive(on: RunLoop.main)
      .sink { [weak self] _ in
        self?.objectWillChange.send()
      }
      .store(in: &cancellables)
  }
  
  var isPageValid: Bool {
    switch currentPage {
    case .nickname: return nicknameViewModel.isNicknameValid
    case .gender: return formData.gender != nil
    case .birthday: return true
    case .area: return !formData.areas.isEmpty
    case .profileImage: return !formData.images.isEmpty
    case .genre: return !formData.genres.isEmpty
    case .favoriteMovie: return formData.movies.count >= 5
    }
  }
  
  func navigateToNextPage() {
    if let nextPage = currentPage.next {
      withAnimation {
        currentPage = nextPage
      }
    } else {
      navigateToApproval = true
    }
  }
  
  func navigateToPreviousPage() {
    if let previousPage = currentPage.previous {
      withAnimation {
        currentPage = previousPage
      }
    }
  }
}
