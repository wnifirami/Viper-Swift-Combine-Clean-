//
//  Viewable.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import UIKit

protocol Viewable: AnyObject {
    func push(_ vc: UIViewController, animated: Bool)
}

extension Viewable where Self: UIViewController {

    func push(_ vc: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}
