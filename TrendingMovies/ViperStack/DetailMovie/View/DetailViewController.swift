//
//  DetailViewController.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import UIKit


protocol DetailViewOutputs: AnyObject {
    func getDetailsFrom( idMovie: Int)
}
protocol DetailViewInputs: AnyObject {
    func configure(entities: MovieDetail)
    func configure(entities: String)
}

class DetailViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    internal var presenter: DetailViewOutputs?
    var movieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if movieId != 0 {
            presenter?.getDetailsFrom(idMovie: movieId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setup() {
        self.title = detailTitle
    }
    
}

extension DetailViewController: Viewable {}

extension DetailViewController: DetailViewInputs {
    func configure(entities: String) {
        showErrorView(with: entities)
        debugPrint("Error while downloading")
    }
    
    func configure(entities: MovieDetail) {
        hideErrorView()
        setViewLayouts(movie: entities)
    }
    
    override func didTapRetry(sender: UIButton) {
        hideErrorView()
        presenter?.getDetailsFrom(idMovie: movieId)
    }
    
    private func setViewLayouts(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.movieImage.setImageWithUrl(url: BaseUrls.image.rawValue.appending(movie.posterPath), radius: 0)
            self.movieDate.text = movie.releaseDate.showYear()
            self.movieTitle.text = movie.title
            self.descriptionLabel.text = movie.overview
        }
    }
    
    
}
