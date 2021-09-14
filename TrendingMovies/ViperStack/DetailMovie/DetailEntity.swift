//
//  DetailEntity.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import Foundation
 
// MARK: - MovieDetail
struct MovieDetail: Codable {
    let id: Int
    let  overview: String
    let posterPath: String
    let releaseDate: String
    let  title: String


    enum CodingKeys: String, CodingKey {
        case  id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title

    }
}
