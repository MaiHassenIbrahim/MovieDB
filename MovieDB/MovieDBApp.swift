//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import SwiftUI

@main
struct MovieDBApp: App {
    var body: some Scene {

            WindowGroup {
                let apiService = MovieAPIService()
                let movieRepository = MovieDataRepository(apiService: apiService)
                let viewModel = MoviesListViewModel(movieRepository: movieRepository)
                MoviesListView(movieListViewModel: viewModel)
            }
        
        }
    
    }


