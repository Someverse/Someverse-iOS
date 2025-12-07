//
//  MovieModel.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let posterURL: URL?
    let releaseYear: Int?

    init(id: String = UUID().uuidString, title: String, posterURL: URL? = nil, releaseYear: Int? = nil) {
        self.id = id
        self.title = title
        self.posterURL = posterURL
        self.releaseYear = releaseYear
    }
}

// MARK: - Sample Data
extension Movie {
    static let samples: [Movie] = [
        Movie(title: "인터스텔라", releaseYear: 2014),
        Movie(title: "기생충", releaseYear: 2019),
        Movie(title: "올드보이", releaseYear: 2003),
        Movie(title: "아바타", releaseYear: 2009),
        Movie(title: "타이타닉", releaseYear: 1997),
        Movie(title: "어벤져스: 엔드게임", releaseYear: 2019),
        Movie(title: "범죄도시", releaseYear: 2017),
        Movie(title: "극한직업", releaseYear: 2019),
        Movie(title: "신과함께", releaseYear: 2017),
        Movie(title: "부산행", releaseYear: 2016),
        Movie(title: "암살", releaseYear: 2015),
        Movie(title: "베테랑", releaseYear: 2015)
    ]
}
