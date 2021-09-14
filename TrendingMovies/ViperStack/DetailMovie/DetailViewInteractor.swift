//
//  DetailViewInteractor.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import Foundation
import Combine

protocol DetailInteractorOutputs: AnyObject {
    func onSuccessSearch(res: MovieDetail)
    func onErrorSearch(error: Error)
}

final class DetailInteractor: Interactorable {
    weak var presenter: DetailInteractorOutputs?
    private var cancallables = Set<AnyCancellable>()
    
    func getMovieDetail(idMovie: Int) {
        MoviesService.shared.getMovieDetail(idMovie: idMovie)
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .failure(let error):
                    self.presenter?.onErrorSearch(error: error)
                case .finished:
                    debugPrint("process Finished")
                }
            } receiveValue: { entities in
                self.presenter?.onSuccessSearch(res: entities)
            }
            .store(in: &self.cancallables)
    }
}
