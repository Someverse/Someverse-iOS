//
//  LoginView.swift
//  Someverse
//
//  Created by 박채현 on 11/28/25.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
  @Environment(\.socialLoginClient.kakaoLogin) private var kakaoLogin
  @Environment(\.socialLoginClient.appleLogin) private var appleLogin
  @Environment(\.nicknameClient) private var nicknameClient
  @State private var navigateToSignUp = false
  @State private var showError = false
  @State private var errorMessage = ""
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Spacer()
        
        VStack(spacing: 12) {
          KakaoLoginButton {
            Task {
              do {
                _ = try await kakaoLogin()
                navigateToSignUp = true
              } catch {
                errorMessage = "카카오 로그인에 실패했습니다."
                showError = true
              }
            }
          }
          
          SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
          } onCompletion: { result in
            switch result {
            case .success:
              navigateToSignUp = true
            case .failure:
              errorMessage = "애플 로그인에 실패했습니다."
              showError = true
            }
          }
          .signInWithAppleButtonStyle(.black)
          .frame(height: 56)
          .cornerRadius(12)
        }
        .padding(.horizontal, 20)
        
        Spacer()
          .frame(height: 24)
        
        termsText
          .padding(.horizontal, 20)
          .padding(.bottom, 40)
      }
      .alert("로그인 실패", isPresented: $showError) {
        Button("확인", role: .cancel) {}
      } message: {
        Text(errorMessage)
      }
      .navigationDestination(isPresented: $navigateToSignUp) {
        SignInView(
          nicknameViewModel: NicknameViewModel(
            validateNickname: nicknameClient.validateNickname,
            saveNickname: nicknameClient.saveNickname
          )
        )
      }
    }
  }
}

// MARK: - Terms Text
private extension LoginView {
  var termsText: some View {
    VStack(spacing: 4) {
      Text("로그인함으로써 ") +
      Text("Somverse").foregroundColor(.someversePrimary) +
      Text("의")
      
      Text("개인 정보 처리방침").foregroundColor(.someverseTextSecondary) +
      Text(" 및 ") +
      Text("이용약관").foregroundColor(.someverseTextSecondary) +
      Text("에 동의합니다.")
    }
    .font(.someverseCaption)
    .foregroundColor(.someverseTextPlaceholder)
    .multilineTextAlignment(.center)
  }
}

#Preview {
  LoginView()
}
