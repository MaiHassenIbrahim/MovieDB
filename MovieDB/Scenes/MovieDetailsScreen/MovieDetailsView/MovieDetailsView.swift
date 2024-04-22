//
//  MovieDetailsView.swift
//  MovieDB
//
//  Created by Mai Hassen on 21/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    
    @ObservedObject var movieDetailsViewModel: MovieDetailsViewModel
   
    let movieId: Int
    
    var body: some View {
        VStack {
            if movieDetailsViewModel.movie == nil {
                ProgressView()
            } else {
                VStack {
                    Text(movieDetailsViewModel.movie?.title ?? "")
                        .padding()
                        .font(.system(size: 26, weight: .bold))
                        
                    
                    if let imageURL = movieDetailsViewModel.movie?.posterURL {
                        WebImage(url: imageURL)
                        
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding()
                            
                         
                    }
                    
                    Text(movieDetailsViewModel.movie?.overview ?? "")
                        .padding()
                        .font(.system(size: 17, weight: .medium))
                    
                    Spacer()
                }
            }
        } 
        .onAppear {
            movieDetailsViewModel.fetchMovieDetails(id: self.movieId)
        }
    }
}
