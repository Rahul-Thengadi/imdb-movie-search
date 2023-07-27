//
//  MovieDetailController.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import UIKit
import StorageProvider

class MovieDetailController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var plotTextView: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var movieDetail: MovieDetailViewModel!
    
    var currentSegment: Int = 0 {
        didSet {
            if currentSegment == 0 {
                ratingLabel.textAlignment = .left
                if movieDetail.rating.count < 1  {
                    ratingLabel.text = "N/A"
                    return
                }
                ratingLabel.text = movieDetail.rating[0]
            } else if currentSegment == 1 {
                ratingLabel.textAlignment = .center
                if movieDetail.rating.count < 2  {
                    ratingLabel.text = "N/A"
                    return
                }
                ratingLabel.text = movieDetail.rating[1]
            } else if currentSegment == 2 {
                ratingLabel.textAlignment = .right
                if movieDetail.rating.count < 3  {
                    ratingLabel.text = "N/A"
                    return
                }
                ratingLabel.text = movieDetail.rating[2]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieDetail.title
        updateUI()
    }
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentSegment = sender.selectedSegmentIndex
    }
    
    private func updateUI() {
        plotTextView.text = movieDetail.plot
        castLabel.text = movieDetail.cast
        releasedDateLabel.text = movieDetail.release
        genreLabel.text = movieDetail.genre
        ratingLabel.textAlignment = .left
        ratingLabel.text = movieDetail.rating[0]
        loadPoster()
    }
    
    private func loadPoster() {
        posterImageView.getImage(with: movieDetail.posterImageURL) { [weak self] result in
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
