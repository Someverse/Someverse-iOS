//
//  DateHelper.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import Foundation

protocol DateProviding {
  var today: Date { get }
  var currentYear: Int { get }
  var currentMonth: Int { get }
  var currentDay: Int { get }
  func age(from year: Int, month: Int, day: Int) -> Int
  func daysInMonth(year: Int, month: Int) -> Int
}

struct DateHelper: DateProviding {
  static let shared = DateHelper()
  
  private let calendar: Calendar
  private let dateProvider: () -> Date
  
  init(calendar: Calendar = .current, dateProvider: @escaping () -> Date = { Date() }) {
    self.calendar = calendar
    self.dateProvider = dateProvider
  }
  
  var today: Date {
    dateProvider()
  }
  
  var currentYear: Int {
    calendar.component(.year, from: today)
  }
  
  var currentMonth: Int {
    calendar.component(.month, from: today)
  }
  
  var currentDay: Int {
    calendar.component(.day, from: today)
  }
  
  func age(from year: Int, month: Int, day: Int) -> Int {
    let birthDate = calendar.date(from: DateComponents(year: year, month: month, day: day)) ?? today
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: today)
    return ageComponents.year ?? 0
  }
  
  func daysInMonth(year: Int, month: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month)
    guard let date = calendar.date(from: dateComponents),
          let range = calendar.range(of: .day, in: .month, for: date) else {
      return 31
    }
    return range.count
  }
}
