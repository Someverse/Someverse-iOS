//
//  AreaPicker.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct AreaPicker: View {
    @Binding var selectedAreas: [Area]
    @State private var isExpanded: Bool = false
    @State private var selectedProvince: Province?
    @State private var selectedDistrict: String?

    private let maxSelections = 2

    var body: some View {
        VStack(spacing: 12) {
            // Search Field / Toggle Button
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("지역을 검색하세요")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(red: 240/255, green: 242/255, blue: 245/255))
                .cornerRadius(8)
            }

            if isExpanded {
                HStack(spacing: 0) {
                    // Province List
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(Province.koreaProvinces) { province in
                                Button(action: {
                                    selectedProvince = province
                                    selectedDistrict = nil
                                }) {
                                    Text(province.name)
                                        .font(.system(size: 14))
                                        .foregroundColor(selectedProvince?.id == province.id ? .black : Color(red: 100/255, green: 100/255, blue: 100/255))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 12)
                                        .background(selectedProvince?.id == province.id ? Color.white : Color.clear)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 245/255, green: 245/255, blue: 245/255))

                    Divider()
                        .frame(width: 1)

                    // District List
                    ScrollView {
                        VStack(spacing: 0) {
                            if let province = selectedProvince {
                                ForEach(province.districts, id: \.self) { district in
                                    Button(action: {
                                        addArea(province: province.name, district: district)
                                    }) {
                                        Text(district)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 12)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                }
                .frame(height: 240)
                .background(Color(red: 240/255, green: 242/255, blue: 245/255))
                .cornerRadius(8)
            }
        }
    }

    private func addArea(province: String, district: String) {
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

struct SelectedAreaChip: View {
    let area: Area
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Text(area.displayName)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(red: 240/255, green: 242/255, blue: 245/255))
        .cornerRadius(16)
    }
}

#Preview {
    VStack {
        AreaPicker(selectedAreas: .constant([]))

        HStack {
            SelectedAreaChip(area: Area(province: "경기도", district: "화성시")) {
                print("Remove")
            }

            SelectedAreaChip(area: Area(province: "서울특별시", district: "서초구")) {
                print("Remove")
            }
        }
    }
    .padding()
}
