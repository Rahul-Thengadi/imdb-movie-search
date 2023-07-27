//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setupPosterImage(with viewModel: MovieViewModel) {
        posterImageView.getImage(with: viewModel.movie.poster) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
}
