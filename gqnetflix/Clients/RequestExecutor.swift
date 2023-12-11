//
//  RequestExecutor.swift
//  gqnetflix
//
//  Created by Yehor Farenbrukh on 10.12.2023.
//

import Foundation
import Combine

private var baseURL = Bundle.main.object(forInfoDictionaryKey: "ENV_URL") as! String

enum RequestExecutor {
    static func executeJSONRequest<T: Decodable>(_ networkRequest: NetworkRequest) -> AnyPublisher<T, ApiError> {
        
        guard let request = prepareRequest(networkRequest) else {
            return Fail(error: ApiError.badRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                return .noInternetConnection
            }
            .flatMap { pair -> AnyPublisher<T, ApiError> in
                if let response = pair.response as? HTTPURLResponse {
                    if (200...499).contains(response.statusCode) {
                        
                        return Just(pair.data)
                            .decode(type: T.self, decoder: liveDecoder())
                            .mapError { error in .decodingFailed(error) }
                            .eraseToAnyPublisher()
                        
                    } else {
                        return Fail(error: ApiError.badServerResponse(response.statusCode)).eraseToAnyPublisher()
                    }
                }
                
                return Fail(error: ApiError.genericError("Invalid server response")).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

private func prepareRequest(_ networkRequest: NetworkRequest) -> URLRequest? {
    var components = URLComponents(string: baseURL + networkRequest.endpoint.route)
    
    if !networkRequest.parameters.isEmpty {
        let queryItems = networkRequest.parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        components?.queryItems = queryItems
    }

    guard let url = components?.url else {
        debugPrint("Bad url")
        return nil
    }

    var request = URLRequest(url: url)
    request.httpMethod = networkRequest.httpMethod.rawValue
    request.allHTTPHeaderFields = networkRequest.headers
    
    request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTNkYTkzNzI2NzhmODg1NTJkYTZlZTc4ZTk0MmYwZiIsInN1YiI6IjVmNDdmOWE3YTJlNjAyMDAzNGY1NjBhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nfQFglIY5GiMZK_Qo-cIPI63K8kiKrSrQR88H5UZ8rs", forHTTPHeaderField: "Authorization")
    
    if let body = networkRequest.body {
        request.httpBody = body
    }
    
    return request
}
