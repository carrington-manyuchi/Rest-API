//
//  Movies.swift
//  Rest API
//
//  Created by DA MAC M1 157 on 2023/06/18.
//

import Foundation

// MARK: - Movies
struct Movies: Decodable {
    
    let movies: [Movie]?

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}



