//
//  ViewController.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 5/9/2021.
//

import UIKit
// MARK: - Protocol

protocol ListViewInputs: AnyObject {
    func update(with movies: Movies)
    func update(with error: String)
}

protocol ListViewOutputs: AnyObject {
    func viewDidLoad()
}

protocol ListEventControlling {
    func didTapCell(item: Movie)
}

// MARK: - View
class TrandingMoviesViewController: UIViewController {
    internal var presenter: ListViewOutputs?
    internal var eventController: ListEventController?
    @IBOutlet weak var tableView: UITableView!
    
    let nib = UINib(nibName: NamesIdentifiers.cellID, bundle: nil)
    
    var moviesArray: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(nib, forCellReuseIdentifier: NamesIdentifiers.cellID)
        
    }
    
    
}

extension TrandingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NamesIdentifiers.cellID, for: indexPath) as? MovieItemCell
        cell?.configureCell(item: moviesArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventController?.didTapCell(item: moviesArray[indexPath.row])
    }
    
}

extension TrandingMoviesViewController: ListViewInputs {
    
    func update(with movies: Movies) {
        hideErrorView()
        DispatchQueue.main.async {
            self.moviesArray = movies.results
        }
    }
    
    func update(with error: String) {
        showErrorView(with: error)
        DispatchQueue.main.async {
            self.moviesArray = []
        }
        
    }
    
    override func didTapRetry(sender: UIButton) {
        hideErrorView()
        presenter?.viewDidLoad()
    }
    
}

extension TrandingMoviesViewController: Viewable {}
