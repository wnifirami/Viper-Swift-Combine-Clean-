//
//  ListMoviesPresenter.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import Foundation

enum FetchError: Error {
    case failed
}

typealias ListPresenterDependencies = (
    interactor: ListInteractor,
    router: ListRouterOutput
)

final class ListPresenter: Presenterable {

    private weak var view: ListViewInputs!
    let dependencies: ListPresenterDependencies
    
    init(
         view: ListViewInputs,
         dependencies: ListPresenterDependencies)
    {
        self.view = view
        self.dependencies = dependencies
    }
}

extension ListPresenter: ListInteractorOutputs {

    
    func onSuccessSearch(res: Movies) {
        view.update(with: res)
    }

    func onErrorSearch(error: Error) {
        view.update(with: error.localizedDescription)
    }
}

extension ListPresenter: ListViewOutputs {
    func viewDidLoad() {
        dependencies.interactor.getMovies()
    }
}

extension ListPresenter: TranslationProtocol {
    func showNextScreen(idMovie: Int) {
        dependencies.router.transitionDetail(withMovieId: idMovie)
    }
    
    
}

