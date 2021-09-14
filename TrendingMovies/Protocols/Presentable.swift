//
//  Presentable.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import Foundation

protocol Presenterable {
    associatedtype I: Interactorable
    associatedtype R: Routerable
    var dependencies: (interactor: I, router: R) { get }
}
