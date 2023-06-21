//
//  Movie.swift
//  Rest API
//
//  Created by DA MAC M1 157 on 2023/06/18.
//

import Foundation

// MARK: - Result
struct Movie: Decodable {
    
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"

    }
}
