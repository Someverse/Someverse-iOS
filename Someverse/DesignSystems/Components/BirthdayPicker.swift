import SwiftUI

struct BirthdayPicker: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: Int

    private var years: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((currentYear - 100)...currentYear)
    }

    private let months = Array(1...12)

    private var days: [Int] {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonth)

        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return Array(1...31)
        }

        return Array(range)
    }

    var body: some View {
        HStack(spacing: 0) {
            // Year Picker
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text("\(year)")
                        .font(.system(size: 20))
                        .tag(year)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)

            // Month Picker
            Picker("Month", selection: $selectedMonth) {
                ForEach(months, id: \.self) { month in
                    Text("\(month)월")
                        .font(.system(size: 20))
                        .tag(month)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .onChange(of: selectedMonth) { _ in
                if selectedDay > days.last ?? 31 {
                    selectedDay = days.last ?? 31
                }
            }

            // Day Picker
            Picker("Day", selection: $selectedDay) {
                ForEach(days, id: \.self) { day in
                    Text("\(day)")
                        .font(.system(size: 20))
                        .tag(day)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 200)
    }
}

#Preview {
    BirthdayPicker(
        selectedYear: .constant(1991),
        selectedMonth: .constant(4),
        selectedDay: .constant(4)
    )
}
