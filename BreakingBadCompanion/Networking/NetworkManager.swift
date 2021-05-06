//
//  NetworkManager.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import Foundation
import Combine

struct NetworkManager {
    private enum HTTPMethod: String {
        case get, post
    }
    
    let session: URLSession = .shared
    var httpHeaders: [String: String]?
    
    func get<T: Decodable>(from url: URL, with decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = httpHeaders
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, _ in
                try decoder.decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
