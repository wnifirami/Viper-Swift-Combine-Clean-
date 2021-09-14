//
//  DetailViewPresenter.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import Foundation

typealias DetailPresenterDependencies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

final class DetailPresenter: Presenterable {

    private weak var view: DetailViewInputs!
    let dependencies: DetailPresenterDependencies

    init(
         view: DetailViewInputs,
         dependencies: DetailPresenterDependencies)
    {
        self.view = view
        self.dependencies = dependencies
    }

}

extension DetailPresenter: DetailViewOutputs {

    func getDetailsFrom( idMovie: Int) {
        dependencies.interactor.getMovieDetail(idMovie: idMovie )
    }
}

extension DetailPresenter: DetailInteractorOutputs {
    func onSuccessSearch(res: MovieDetail) {
        view.configure(entities: res)
    }
    
    func onErrorSearch(error: Error) {
        view.configure(entities: error.localizedDescription)
    }
}

