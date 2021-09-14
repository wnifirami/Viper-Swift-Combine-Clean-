//
//  ListMoviesRouter.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//


import Foundation
import UIKit

struct ListRouterInput {

     func view() -> TrandingMoviesViewController {
        let view = TrandingMoviesViewController.initFromNib()
        let interactor = ListInteractor()
        let dependencies = ListPresenterDependencies(interactor: interactor, router: ListRouterOutput(view))
        let presenter = ListPresenter( view: view, dependencies: dependencies)
        view.presenter = presenter
        view.eventController = ListEventController(presenter: presenter)
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable) {
        let view = self.view()
        from.push(view, animated: true)
    }
}

final class ListRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

    func transitionDetail(withMovieId: Int) {
        DetailRouterInput().push(from: view, withMovieId: withMovieId)
    }
}
