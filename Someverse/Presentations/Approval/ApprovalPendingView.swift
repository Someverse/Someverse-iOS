//
//  ApprovalPendingView.swift
//  Someverse
//
//  Created by 박채현 on 12/3/25.
//

import SwiftUI

struct ApprovalPendingView: View {
  var body: some View {
    VStack(spacing: 0) {
      // Header
      Text("승인대기")
        .font(.someverseBody)
        .foregroundColor(.someverseTextPrimary)
        .padding(.top, 20)
      
      Spacer()
        .frame(height: 40)
      
      // Title
      VStack(alignment: .leading, spacing: 8) {
        Text("가입 승인\n대기 중이에요!")
          .font(.someverseTitle)
          .foregroundColor(.someverseTextTitle)
          .lineSpacing(4)
        
        Text("안전한 사용을 위해 회원님의 정보를 확인하고 있어요!")
          .font(.someverseBodyRegular)
          .foregroundColor(.someverseTextSecondary)
          .padding(.top, 4)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      
      Spacer()
      
      // CTA Button - disabled
      CTAButton(
        title: "승인 전 기다려 주세요",
        isEnabled: false
      ) {
        // No action - button is disabled
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 40)
    }
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    .interactiveDismissDisabled(true)
    .gesture(DragGesture(minimumDistance: 0), including: .all)
  }
}

#Preview {
  ApprovalPendingView()
}
