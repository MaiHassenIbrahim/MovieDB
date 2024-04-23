//
//  MoviesListView.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftUIInfiniteList
struct MoviesListView: View {
    
    @State private var selectedMovie: Movie? = nil
    @ObservedObject var movieListViewModel: MoviesListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if movieListViewModel.movies.isEmpty {
                    if movieListViewModel.isMovieApiCalled {
                        ProgressView()
                    } else {
                        Text("Empty")
                    }
                } else {
                    
                    InfiniteList(data: $movieListViewModel.movies,
                                 isLoading: $movieListViewModel.isLoading,
                                 loadingView: ProgressView(),
                                 loadMore: movieListViewModel.loadMore) { movie in
                        
                        if let imageUrl = movie.posterURL {
                            Button(action: {
                                selectedMovie = movie
                            }) {
                                
                                HStack(spacing: 0){
                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 170)
                                        .cornerRadius(10)
                                        .padding(.vertical, 25)
                                        .padding(.leading, 25)
                                    VStack(alignment: .leading){
                                        Spacer().frame(height: 10)
                                        Text(movie.title)
                                            .font(.system(size: 20, weight: .bold))
                                            .padding(.top,20)
                                            .padding(.leading,4)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                        Text(movie.year)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(4)
                                        Spacer()
                                    }.padding()
                                    Spacer()
                                }
                                .background(.black)
                                .cornerRadius(18)
                                .accessibilityIdentifier("MovieListItem")
                                
                            }
                            
                        }
                    }
                }
                
                
            }
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {
                    // sort by title
                    movieListViewModel.sortList()
                }, label: {
                    Image(systemName: "arrow.up.arrow.down").resizable()
                    Text("Sort")
                    
                    
                }).tint(.purple)
                
            })
            .searchable(text: $movieListViewModel.searchText, prompt: Text("Search text..."))
            
            .navigationTitle("Movies")
            .sheet(item: $selectedMovie) { movie in
                // go to details screen
                MovieDetailsView(movieDetailsViewModel: movieListViewModel.launchMovieDetailsData(), movieId: movie.id)
                
            }
            .onAppear {
                movieListViewModel.fetchMovies()
            }
            .alert(item: $movieListViewModel.apiError) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
            }
        }
    }
}


