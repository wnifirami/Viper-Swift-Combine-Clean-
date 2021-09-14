//
//  ListMoviesInteractor.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import Foundation
import Combine

protocol ListInteractorOutputs: AnyObject {
    func onSuccessSearch(res: Movies)
    func onErrorSearch(error: Error)
}

final class ListInteractor: Interactorable {

    weak var presenter: ListInteractorOutputs?
    private var cancallables = Set<AnyCancellable>()
        
        func getMovies() {
            MoviesService.shared.fetchMovies()
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
