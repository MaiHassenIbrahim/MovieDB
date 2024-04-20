//
//  APIEndpoint.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import Foundation


enum APIEndpoint {
    case moviesList
    case movieDetails(id: Int)
}

extension APIEndpoint: EndPoint {
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .moviesList:
            return "/3/discover/movie"
        case .movieDetails(let id):
            return "/3/movie/\(id)"
        }
    }
    
    private var apiKey: String {
        return "9a1ba21f7104aed688c34f2bcb4a09f4"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .moviesList:
            return .get
        case .movieDetails:
            return .post
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .moviesList:
            return ["api_key": apiKey, "limit": "10"]
        case .movieDetails:
            return ["api_key": apiKey]
        }
    }
}

protocol EndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String] { get }
}

enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
}

