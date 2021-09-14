//
//  TableViewCell.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import UIKit


class MovieItemCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieDate: UILabel!
    
 
    
    func configureCell(item: Movie) {
        movieImage.setImageWithUrl(url: BaseUrls.image.rawValue.appending(item.posterPath), radius: 0)
        MovieTitle.text = item.originalTitle
        MovieDate.text = item.releaseDate.showYear()
    }

}
