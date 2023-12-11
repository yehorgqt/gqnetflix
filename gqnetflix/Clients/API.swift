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

    var route: String {
        switch self {
        case .trandingMovies: return "/trending/all/day?language=en-US"
        }
    }
}
