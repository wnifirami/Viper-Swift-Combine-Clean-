//
//  DetailViewRouter.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import Foundation
import UIKit

struct DetailRouterInput {

    private func view() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let dependencies = DetailPresenterDependencies(interactor: interactor, router: DetailRouterOutput(view))
        let presenter = DetailPresenter(view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, withMovieId: Int) {
        let view = self.view()
        view.movieId = withMovieId
        from.push(view, animated: true)
    }

}

final class DetailRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

}

