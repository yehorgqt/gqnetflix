//
//  MoviesClient.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import Combine

struct MoviesClient {
    var fetchMovies: (_ request: NetworkRequest) -> AnyPublisher<MoviesResponse, ApiError>
}

extension MoviesClient {
    static let live = MoviesClient(
        fetchMovies: { request in
            return RequestExecutor.executeJSONRequest(request).eraseToAnyPublisher()
        }
    )
}

