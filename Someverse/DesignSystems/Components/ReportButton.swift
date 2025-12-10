//
//  ReportButton.swift
//  Someverse
//
//  Created by 박채현 on 12/10/25.
//

import SwiftUI

struct ReportButton: View {
  var onReport: (() -> Void)?

  var body: some View {
    Button {
      onReport?()
    } label: {
      Image.iconBell
        .font(.someverseIconMedium)
        .foregroundColor(.someverseInactive)
    }
  }
}

#Preview {
  ReportButton {
    print("Report tapped")
  }
}
