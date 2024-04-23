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
    @Published var isLoading = false
    private var page = 1
    private let movieRepository: MoviesListRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieRepository: MoviesListRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() {
        movieRepository.fetchMovies(page: 1)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.page += 1
                if case let .failure(error) = completion {
                    self.apiError = error as? APIError
                }
            } receiveValue: { movies in
                self.movies = movies
            }
            .store(in: &cancellables)
    }
    func loadMore() {
            guard !isLoading else { return }
            
            isLoading = true
        movieRepository.fetchMovies(page: self.page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                self.page += 1
                if case let .failure(error) = completion {
                    self.apiError = error as? APIError
                }
            } receiveValue: { movies in
                self.movies.append(contentsOf: movies) 
            }
            .store(in: &cancellables)
        }
    

    func launchMovieDetailsData() -> MovieDetailsViewModel{
        let apiService = MovieAPIService()
        let movieRepository = MovieDetailsDataRepository(apiService: apiService)
        let viewModel = MovieDetailsViewModel(movieDetailsRepository: movieRepository)
        return viewModel
     
    }
}
