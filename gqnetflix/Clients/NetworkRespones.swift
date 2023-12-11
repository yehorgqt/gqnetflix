//
//  NetworkRespones.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import Foundation

struct MoviesResponse: Decodable, Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
}
