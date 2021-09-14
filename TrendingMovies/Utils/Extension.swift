//
//  Extension.swift
//  TrendingMovies
//
//  Created by Rami Ounifi on 6/9/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageWithUrl(url: String, placeholder: UIImage? = nil, radius: CGFloat) {
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: radius)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}


extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)  }
        return instanceFromNib()
    }
    
    func showErrorView(with error: String) {
        let errorView = UIView()
        self.view.addSubview(errorView)
        let label = UILabel()
        errorView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = .white
        errorView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = error
        label.textAlignment = .center
        
        button.setTitleColor(.black, for: .normal)

        errorView.backgroundColor = .gray
        errorView.tag = 100
        errorView.layer.cornerRadius = 10
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        errorView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        errorView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        
     
        label.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: errorView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualTo: errorView.widthAnchor, multiplier: 0.9).isActive = true
        label.bottomAnchor.constraint(greaterThanOrEqualTo: button.topAnchor, constant: 10).isActive = true
        
        button.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: errorView.bottomAnchor).isActive = true
        button.widthAnchor.constraint(lessThanOrEqualTo: errorView.widthAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: errorView.widthAnchor, multiplier: 0.5).isActive = true
        
        
        button.addTarget(self, action: #selector(didTapRetry(sender:)), for: .touchUpInside)
        
    }
    
    @objc func didTapRetry(sender: UIButton) {}
    
    func hideErrorView() {
       _ = self.view.subviews.filter({$0.tag == 100}).map({($0.removeFromSuperview())})
    }
    
}

extension String {
    func showYear() -> String {
        let formatter = "yyyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        guard let date = dateFormatter.date(from: self) else { return "Error in date" }
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy"
        return newDateFormatter.string(from: date)
    }
}
