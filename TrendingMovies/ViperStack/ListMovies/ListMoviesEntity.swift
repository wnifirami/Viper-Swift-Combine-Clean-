//
//  ListMoviesEntity.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import Foundation

// MARK: - Movie
struct Movies: Codable {
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    let originalTitle, overview: String
    let posterPath, releaseDate, title: String


    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title

    }
}

