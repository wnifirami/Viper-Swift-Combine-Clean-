//
//  MoviesServices.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import Foundation
import Combine

protocol MoviesServiceProtocol: AnyObject {
    func fetchMovies() -> AnyPublisher<Movies, Error>
    func getMovieDetail(idMovie: Int)  -> AnyPublisher<MovieDetail, Error>
}

class MoviesService: MoviesServiceProtocol {
    
    static let shared = MoviesService()
    
    func fetchMovies() -> AnyPublisher<Movies, Error> {
        guard let url = URL(string: EndPoints.listMovies.description) else {
            return Future<Movies, Error>(){ promise in
                promise(.failure(FetchError.failed))
            }.eraseToAnyPublisher()
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: Movies.self,
                    decoder: JSONDecoder())
            .catch { error in
                Future<Movies, Error>(){ promise in
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }
    
    func getMovieDetail(idMovie: Int)  -> AnyPublisher<MovieDetail, Error> {
        let urlString = EndPoints.detail.description + "/\(idMovie)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Future<MovieDetail, Error>(){ promise in
                promise(.failure(FetchError.failed))
            }.eraseToAnyPublisher()
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: MovieDetail.self,
                    decoder: JSONDecoder())
            .catch { error in
                Future<MovieDetail, Error>(){ promise in
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }
}


