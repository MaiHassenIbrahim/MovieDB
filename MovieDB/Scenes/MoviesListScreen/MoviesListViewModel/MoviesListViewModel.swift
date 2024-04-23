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
    @Published var allMovies: [Movie] = []
    @Published var apiError: APIError?
    @Published var isLoading = false
    var isMovieApiCalled = true
    var searchText: String = "" {
        didSet {
            self.search()
        }
    }
    
    private var page = 1
    private let movieRepository: MoviesListRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieRepository: MoviesListRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() {
        isMovieApiCalled = true
        movieRepository.fetchMovies(page: 1)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.page += 1
                if case let .failure(error) = completion {
                    self.apiError = error as? APIError
                }
            } receiveValue: { movies in
                self.movies = movies
                self.allMovies = movies
            }
            .store(in: &cancellables)
    }
    func loadMore() {
        
            guard !isLoading && isMovieApiCalled else { return }
        isMovieApiCalled = true
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
                self.allMovies.append(contentsOf: movies)
            }
            .store(in: &cancellables)
        }
    
    func sortList() {
        movies.sort(by: {$0.title.lowercased() < $1.title.lowercased()})
    }
    
    func search() {
        isMovieApiCalled = false
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            let searchedList = self.movies.compactMap({ item in
                if (item.title.lowercased().contains(searchText.lowercased())) {
                    return item
                }
                return nil
            })
            self.movies = searchedList
         
        } else {
            self.movies = allMovies
            isMovieApiCalled = true
        }
    }
    func launchMovieDetailsData() -> MovieDetailsViewModel{
        let apiService = MovieAPIService()
        let movieRepository = MovieDetailsDataRepository(apiService: apiService)
        let viewModel = MovieDetailsViewModel(movieDetailsRepository: movieRepository)
        return viewModel
     
    }
}
