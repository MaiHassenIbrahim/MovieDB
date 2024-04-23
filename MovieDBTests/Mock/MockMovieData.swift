//
//  MockMovieData.swift
//  MovieDBTests
//
//  Created by Mai Hassen on 23/04/2024.
//

import Foundation
import Combine
@testable import MovieDB

//class MockMoviekData {
//   
//    
//    static let fileType = "json"
//    static let fileReadError = "File not readable"
//    static let fileNotFoundError = "File not found"
//    
//    static func load(name: String) throws -> Data? {
//        let bundle = Bundle.init(for: MockMoviekData.self)
//        
//        if let path = bundle.path(forResource: name, ofType: fileType) {
//            let fileUrl = URL.init(fileURLWithPath: path)
//            do {
//                let data = try Data.init(contentsOf: fileUrl)
//                return data
//            } catch {
//                let error = fileReadError as! Error
//                throw error
//            }
//        } else {
//            let error = fileNotFoundError as! Error
//            throw error
//        }
//    }
//    
//    func fetchMovies(page: Int) -> AnyPublisher<[MovieDB.Movie], Error> {
//        
//    }
//}

//struct MockApiClient: APIService {
//    func request<T>(endpoint: MovieDB.APIEndpoint) -> AnyPublisher<T, Error> where T : Decodable {
//        Just(Response(message: ["Labradoodle": []]) as! T)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
//}

//struct Response: Decodable, Equatable {
//    let results: [Movie]
//}

struct MockMovieRespository: MoviesListRepository {
    
    let apiClient: APIService

    func fetchMovies(page: Int) -> AnyPublisher<[MovieDB.Movie], Error> {
        let endpoint = APIEndpoint.moviesList(page: page)
        return apiClient.request(endpoint: endpoint)
            .map { (response: MovieListResponse) -> [Movie] in
                return Array(response.results.prefix(10))
            }
            .eraseToAnyPublisher()
    }
        
}
