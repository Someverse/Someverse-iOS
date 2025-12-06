//
//  BirthdayPageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

struct BirthdayPageView: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("생년월일을 알려주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.someverseTextTitle)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 8) {
                birthdayPicker
                ageDisplay
            }
        }
        .padding(.horizontal, 24)
    }

    private var ageDisplay: some View {
        let calculatedAge = DateHelper.shared.age(
            from: selectedYear,
            month: selectedMonth,
            day: selectedDay
        )

        return Group {
            if calculatedAge >= 0 {
                Text("만 \(calculatedAge)세")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextPrimary)
            } else {
                Text("올바른 날짜를 선택해주세요")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseError)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Birthday Picker
private extension BirthdayPageView {
    var years: [Int] {
        let currentYear = DateHelper.shared.currentYear
        return Array((currentYear - 100)...currentYear)
    }

    var months: [Int] {
        Array(1...12)
    }

    var days: [Int] {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonth)

        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return Array(1...31)
        }

        return Array(range)
    }

    var birthdayPicker: some View {
        HStack(spacing: 0) {
            makeDatePicker(
                title: "Year",
                items: years,
                selection: $selectedYear,
                format: { "\($0.formatted(.number.grouping(.never)))년" }
            )

            makeDatePicker(
                title: "Month",
                items: months,
                selection: $selectedMonth,
                format: { "\($0)월" }
            )

            makeDatePicker(
                title: "Day",
                items: days,
                selection: $selectedDay,
                format: { "\($0)일" }
            )
        }
        .frame(height: 200)
        .onChange(of: selectedYear) { _ in adjustDayIfNeeded() }
        .onChange(of: selectedMonth) { _ in adjustDayIfNeeded() }
    }

    func makeDatePicker(
        title: String,
        items: [Int],
        selection: Binding<Int>,
        format: @escaping (Int) -> String
    ) -> some View {
        Picker(title, selection: selection) {
            ForEach(items, id: \.self) { item in
                Text(format(item))
                    .font(.someversePicker)
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
        .frame(maxWidth: .infinity)
    }

    func adjustDayIfNeeded() {
        let maxDay = days.last ?? 31
        if selectedDay > maxDay {
            selectedDay = maxDay
        }
    }
}

#Preview {
    BirthdayPageView(
        selectedYear: .constant(DateHelper.shared.currentYear),
        selectedMonth: .constant(DateHelper.shared.currentMonth),
        selectedDay: .constant(DateHelper.shared.currentDay)
    )
}
