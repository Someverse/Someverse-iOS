//
//  Date+.swift
//  Someverse
//
//  Created by 박채현 on 12/7/25.
//

import Foundation

extension Date {
  var chatTimeString: String {
    let now = Date()
    let interval = now.timeIntervalSince(self)

    // 1시간 이내
    if interval < 3600 {
      let minutes = Int(interval / 60)
      return "\(max(1, minutes))분 전"
    }

    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")

    if calendar.isDateInToday(self) {
      formatter.dateFormat = "a h:mm"
    } else if calendar.isDateInYesterday(self) {
      return "어제"
    } else if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
      formatter.dateFormat = "M월 d일"
    } else {
      formatter.dateFormat = "yyyy.M.d"
    }

    return formatter.string(from: self)
  }
}
