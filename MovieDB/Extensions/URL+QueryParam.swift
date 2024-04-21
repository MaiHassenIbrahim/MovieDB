//
//  URL+QueryParam.swift
//  MovieDB
//
//  Created by Mai Hassen on 21/04/2024.
//


import Foundation

extension URLComponents {
    mutating func setQueryItems(_ parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
