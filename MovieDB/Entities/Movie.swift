//
//  Movie.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import Foundation

struct Movie: Decodable, Hashable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let imageBaseUrl = "https://image.tmdb.org/t/p/original/"
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = imageBaseUrl + posterPath
        return URL(string: urlString)
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: releaseDate) ?? Date()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        return year
    }
}

struct MovieListResponse: Decodable, Equatable {
    let results: [Movie]
}
