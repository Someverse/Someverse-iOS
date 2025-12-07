//
//  TasteModel.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import Foundation

struct MovieGenre: Identifiable, Equatable, Hashable {
    var id: String { name }
    let name: String
}

extension MovieGenre {
    static let allGenres: [MovieGenre] = [
        MovieGenre(name: "뮤지컬"),
        MovieGenre(name: "공포/호러"),
        MovieGenre(name: "애니메이션"),
        MovieGenre(name: "로맨스"),
        MovieGenre(name: "다큐멘터리"),
        MovieGenre(name: "스릴러/범죄"),
        MovieGenre(name: "코미디"),
        MovieGenre(name: "SF"),
        MovieGenre(name: "전쟁/사극"),
        MovieGenre(name: "판타지/모험"),
        MovieGenre(name: "드라마"),
        MovieGenre(name: "액션")
    ]
}
