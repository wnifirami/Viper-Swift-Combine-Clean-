//
//  ListEventController.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import UIKit
protocol TranslationProtocol: AnyObject {
    func showNextScreen(idMovie: Int)
}
final class ListEventController: ListEventControlling {
    private weak var presenter: TranslationProtocol?
    
    init(presenter: TranslationProtocol) {
        self.presenter = presenter
    }
    func didTapCell(item: Movie) {
        presenter?.showNextScreen(idMovie: item.id)
    }
    
    
}
