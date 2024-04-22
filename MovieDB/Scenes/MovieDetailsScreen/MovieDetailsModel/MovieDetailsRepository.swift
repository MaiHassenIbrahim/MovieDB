//
//  MovieDetailsRepository.swift
//  MovieDB
//
//  Created by Mai Hassen on 21/04/2024.
//

import Foundation
import Combine

protocol MovieDetailsRepository {
    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error>
}

class MovieDetailsDataRepository: MovieDetailsRepository {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error> {
        let endpoint = APIEndpoint.movieDetails(id: id)
        return apiService.request(endpoint: endpoint)
            .map { (response: Movie) -> Movie in
                return response
            }
            .eraseToAnyPublisher()
    }
}
