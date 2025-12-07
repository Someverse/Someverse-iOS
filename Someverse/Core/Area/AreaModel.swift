//
//  AreaModel.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import Foundation

struct Area: Identifiable, Equatable, Hashable {
    var id: String {
        "\(province)-\(district)"
    }
    let province: String
    let district: String

    var displayName: String {
        "\(province) \(district)"
    }
}

struct Province: Identifiable, Equatable {
    var id: String { name }
    let name: String
    let districts: [String]
}

extension Province {
    static let koreaProvinces: [Province] = [
        Province(name: "강원도", districts: ["강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시"]),
        Province(name: "경상남도", districts: ["거제시", "김해시", "마산시", "밀양시", "사천시", "양산시", "진주시", "창원시", "통영시"]),
        Province(name: "경상북도", districts: ["경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시", "영천시", "포항시"]),
        Province(name: "경기도", districts: ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]),
        Province(name: "대구광역시", districts: ["남구", "달서구", "동구", "북구", "서구", "수성구", "중구"]),
        Province(name: "서울특별시", districts: ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]),
        Province(name: "부산광역시", districts: ["강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]),
        Province(name: "인천광역시", districts: ["계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "중구"]),
        Province(name: "광주광역시", districts: ["광산구", "남구", "동구", "북구", "서구"]),
        Province(name: "대전광역시", districts: ["대덕구", "동구", "서구", "유성구", "중구"]),
        Province(name: "울산광역시", districts: ["남구", "동구", "북구", "중구"]),
    ]
}
