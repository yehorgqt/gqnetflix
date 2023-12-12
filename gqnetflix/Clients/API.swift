//
//  API.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import Foundation

// MARK: - Api Errors
public enum ApiError: Error, Equatable {
    public static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    case badServerResponse(Int)
    case decodingFailed(Error)
    case encodingFailed(Error)
    case noInternetConnection
    case badRequest
    case genericError(String)
}

// MARK: - Network request
public struct NetworkRequest {
    let httpMethod: HTTPMethod
    let endpoint: Endpoint
    var parameters: Parameters = [:]
    var headers: Headers = ["Content-Type": "application/json", "Device-Type": "ios"]
    var body: Data? = nil
}

// MARK: - Request methods
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - Endpoints
public enum Endpoint {
    case trandingMovies
    case trandingTV
    case upcomingMovies
    case popularMovies
    case topRated
    case topSearch
    case search(_ query: String)

    var route: String {
        switch self {
        case .trandingMovies: return "/trending/movie/day?language=en-US"
        case .trandingTV: return "/trending/tv/day?language=en-US"
        case .upcomingMovies: return "/movie/upcoming?language=en-US"
        case .popularMovies: return "/movie/popular?language=en-US"
        case .topRated: return "/movie/top_rated?language=en-US"
        case .topSearch: return "/discover/movie?language=en-US&sort_by=popularity.desc"
        case .search(let query): return "/search/movie?query=\(query)&language=en-US&sort_by=popularity.desc"
        }
    }
}
