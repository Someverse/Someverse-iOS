//
//  AreaPageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

struct AreaPageView: View {
    @Binding var selectedAreas: [Area]
    @State private var isExpanded: Bool = false
    @State private var selectedProvince: Province?

    private let maxSelections = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            headerSection
            areaPicker
            selectedAreasView
        }
        .padding(.horizontal, 24)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("주 활동 지역을 알려주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.someverseTextTitle)

            Text("최대 2개 지역까지 선택할 수 있어요!")
                .font(.someverseBodyRegular)
                .foregroundColor(.someverseTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Area Picker
private extension AreaPageView {
    var areaPicker: some View {
        VStack(spacing: 12) {
            PickerToggleButton(isExpanded: isExpanded) {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                pickerContent
            }
        }
    }

    var pickerContent: some View {
        HStack(spacing: 0) {
            makePickerColumn(
                items: Province.koreaProvinces.map { $0.name },
                selectedItem: selectedProvince?.name,
                backgroundColor: Color.someverseBackgroundSecondary
            ) { name in
                selectedProvince = Province.koreaProvinces.first { $0.name == name }
            }

            Divider().frame(width: 1)

            if let districts = selectedProvince?.districts {
                makePickerColumn(
                    items: districts,
                    selectedItem: nil,
                    backgroundColor: Color.white
                ) { district in
                    guard let province = selectedProvince else { return }
                    addArea(province: province.name, district: district)
                }
            } else {
                Color.white
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 240)
        .background(Color.someverseBackground)
        .cornerRadius(8)
    }

    func makePickerColumn(
        items: [String],
        selectedItem: String?,
        backgroundColor: Color,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    PickerItemButton(
                        title: item,
                        isSelected: selectedItem == item,
                        action: { onSelect(item) }
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
    }

    func addArea(province: String, district: String) {
        guard selectedAreas.count < maxSelections else { return }

        let newArea = Area(province: province, district: district)
        if !selectedAreas.contains(newArea) {
            selectedAreas.append(newArea)
        }

        withAnimation {
            isExpanded = false
        }
        selectedProvince = nil
    }
}

// MARK: - Picker Toggle Button
private struct PickerToggleButton: View {
    let isExpanded: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("지역을 검색하세요")
                    .font(.someverseBody)
                    .foregroundColor(.someverseTextTertiary)

                Spacer()

                Image(systemName: "chevron.down")
                    .font(.someverseLabel)
                    .foregroundColor(.someverseTextTertiary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.someverseBackground)
            .cornerRadius(8)
        }
    }
}

// MARK: - Picker Item Button
private struct PickerItemButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.someverseLabel)
                .foregroundColor(isSelected ? .someverseTextTitle : .someverseTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(isSelected ? Color.white : Color.clear)
        }
    }
}

// MARK: - Selected Areas
private extension AreaPageView {
    @ViewBuilder
    var selectedAreasView: some View {
        if !selectedAreas.isEmpty {
            HStack(spacing: 8) {
                ForEach(selectedAreas) { area in
                    SelectedAreaChip(area: area) {
                        selectedAreas.removeAll { $0.id == area.id }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Selected Area Chip
private struct SelectedAreaChip: View {
    let area: Area
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Text(area.displayName)
                .font(.someverseLabel)
                .foregroundColor(.someverseTextPrimary)

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.someverseBody)
                    .foregroundColor(.someverseTextTertiary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.someverseBackground)
        .cornerRadius(16)
    }
}

#Preview {
    AreaPageView(selectedAreas: .constant([
        Area(province: "경기도", district: "화성시")
    ]))
}
