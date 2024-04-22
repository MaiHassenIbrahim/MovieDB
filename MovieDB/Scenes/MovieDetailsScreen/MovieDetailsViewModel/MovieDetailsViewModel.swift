//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Mai Hassen on 21/04/2024.
//

import Foundation
import Combine


class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var error: APIError?
    
    private let movieDetailsRepository: MovieDetailsRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieDetailsRepository: MovieDetailsRepository) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    func fetchMovieDetails(id: Int) {
        movieDetailsRepository.fetchMovieDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.error = error as? APIError
                }
            } receiveValue: { movie in
                self.movie = movie
            }
            .store(in: &cancellables)
    }
}
