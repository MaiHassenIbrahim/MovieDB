//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var apiError: APIError?
    
    private let movieRepository: MoviesListRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieRepository: MoviesListRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() {
        movieRepository.fetchMovies()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.apiError = error as? APIError
                }
            } receiveValue: { movies in
                self.movies = movies
            }
            .store(in: &cancellables)
    }
}
