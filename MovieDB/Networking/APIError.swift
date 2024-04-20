//
//  APIError.swift
//  MovieDB
//
//  Created by Mai Hassen on 20/04/2024.
//

import Foundation

enum APIError: Error, Identifiable {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    var id: String {
        switch self {
        case .invalidURL:
            return "InvalidURL"
        case .invalidResponse:
            return "InvalidResponse"
        case .statusCode(let statusCode):
            return "StatusCode\(statusCode)"
        }
    }
}
