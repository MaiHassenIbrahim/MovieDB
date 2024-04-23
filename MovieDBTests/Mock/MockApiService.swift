//
//  MockApiService.swift
//  MovieDBTests
//
//  Created by Mai Hassen on 23/04/2024.
//

import Foundation
import Foundation
import Combine
@testable import MovieDB

struct MockApiService: APIService {
    func request<T: Decodable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        Just(MovieListResponse(results: []) as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
