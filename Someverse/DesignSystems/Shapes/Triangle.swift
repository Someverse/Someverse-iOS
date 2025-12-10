//
//  Triangle.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import SwiftUI

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.closeSubpath()
    return path
  }
}

#Preview {
  VStack {
    RoundedRectangle(cornerRadius: 12)
      .fill(Color.white)
      .frame(width: 200, height: 100)

    Triangle()
      .fill(Color.white)
      .frame(width: 20, height: 12)

    Circle()
      .fill(Color.gray)
      .frame(width: 50, height: 50)
  }
}
