//
//  EndPoint.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import Foundation

 enum BaseUrls: String {
    case usine = "https://api.themoviedb.org/3/"
    case image = "https://image.tmdb.org/t/p/w500/"
}

struct APISettings {
    static var serverUrl: String = {
        return BaseUrls.usine.rawValue
    }()
}


 enum EndPoints: String {
    case listMovies
    case detail
    var path : String {
        switch self {
        case .listMovies: return "discover/movie?api_key=\(apiKey)"
        case .detail: return "/movie"
        }
    }
}

extension EndPoints: CustomStringConvertible {
    var description: String { return APISettings.serverUrl.appending(path)  }
}
