//
//  MoviesListRepository.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import Foundation
import Combine

protocol MoviesListRepository {
    func fetchMovies(page: Int) -> AnyPublisher<[Movie], Error>
}

class MovieDataRepository: MoviesListRepository {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        let endpoint = APIEndpoint.moviesList(page: page)
        return apiService.request(endpoint: endpoint)
            .map { (response: MovieListResponse) -> [Movie] in
                return Array(response.results.prefix(10))
            }
            .eraseToAnyPublisher()
    }
}
