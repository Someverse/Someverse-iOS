//
//  ChipView.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

// MARK: - Chip Style
enum ChipStyle {
  case outline           // 테두리만 있는 스타일
  case filled            // 배경색이 있는 스타일
  case primary           // 그라데이션 배경
  case genre             // 장르용 (회색 배경 + 테두리)
}

// MARK: - Chip View
struct ChipView: View {
  let text: String
  var style: ChipStyle = .outline

  var body: some View {
    Text(text)
      .font(.someverseChip)
      .foregroundColor(foregroundColor)
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .background(background)
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(strokeColor, lineWidth: strokeWidth)
      )
  }

  private var foregroundColor: Color {
    switch style {
    case .outline, .genre:
      return .someverseTextPrimary
    case .filled:
      return .someverseTextPrimary
    case .primary:
      return .someverseTextWhite
    }
  }

  @ViewBuilder
  private var background: some View {
    switch style {
    case .outline:
      Color.someverseBackgroundWhite
    case .filled:
      Color.someverseBackgroundSecondary
    case .primary:
      LinearGradient.someversePrimary
    case .genre:
      Color.someverseBackgroundSecondary
    }
  }

  private var strokeColor: Color {
    switch style {
    case .outline, .filled, .genre:
      return .someverseInactive
    case .primary:
      return .clear
    }
  }

  private var strokeWidth: CGFloat {
    style == .primary ? 0 : 1
  }
}

// MARK: - Location Chip (위치용 특수 Chip)
struct LocationChip: View {
  let text: String
  let isPrimary: Bool

  var body: some View {
    ChipView(text: text, style: isPrimary ? .primary : .outline)
  }
}

// MARK: - Flow Layout
struct FlowLayout: Layout {
  var spacing: CGFloat = 8

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
    return result.size
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
    for (index, subview) in subviews.enumerated() {
      subview.place(
        at: CGPoint(
          x: bounds.minX + result.positions[index].x,
          y: bounds.minY + result.positions[index].y
        ),
        proposal: .unspecified
      )
    }
  }

  struct FlowResult {
    var size: CGSize = .zero
    var positions: [CGPoint] = []

    init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
      var x: CGFloat = 0
      var y: CGFloat = 0
      var rowHeight: CGFloat = 0

      for subview in subviews {
        let size = subview.sizeThatFits(.unspecified)

        if x + size.width > maxWidth && x > 0 {
          x = 0
          y += rowHeight + spacing
          rowHeight = 0
        }

        positions.append(CGPoint(x: x, y: y))
        rowHeight = max(rowHeight, size.height)
        x += size.width + spacing

        self.size.width = max(self.size.width, x - spacing)
      }

      self.size.height = y + rowHeight
    }
  }
}

#Preview {
  VStack(alignment: .leading, spacing: 20) {
    Text("Chip Styles")
      .font(.someverseHeadline)

    HStack {
      ChipView(text: "Outline", style: .outline)
      ChipView(text: "Filled", style: .filled)
      ChipView(text: "Primary", style: .primary)
      ChipView(text: "Genre", style: .genre)
    }

    Text("Location Chips")
      .font(.someverseHeadline)

    HStack {
      LocationChip(text: "서울특별시 성북구", isPrimary: true)
      LocationChip(text: "경기도 화성시", isPrimary: false)
    }

    Text("Flow Layout")
      .font(.someverseHeadline)

    FlowLayout(spacing: 8) {
      ChipView(text: "뮤지컬", style: .genre)
      ChipView(text: "스릴러/범죄", style: .genre)
      ChipView(text: "드라마", style: .genre)
      ChipView(text: "코미디", style: .genre)
      ChipView(text: "애니메이션", style: .genre)
    }
    .frame(width: 300)
  }
  .padding()
}
