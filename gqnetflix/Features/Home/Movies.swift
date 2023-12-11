//
//  Movies.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String?
    let name: String?
    let posterPath: String?
    let releaseDate: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Double
    let overview: String?
}

extension Movie {
    var safeName: String {
        if let title { return title }
        if let name { return name }
        return ""
    }
}
