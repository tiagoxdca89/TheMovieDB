//
//  SearchCell.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Class

class SearchCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseIdentifier = "SearchCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    // MARK: - Public methods

    func setupCell(movie: Movie) {
        title.text = movie.title
        year.text = String(movie.release_date?.prefix(4) ?? "")
        rate.text = "\(movie.vote_average ?? 0) | 10"
        setupImage(url: movie.getPosterEndPoint(), imageView: posterImageView)
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.borderColor = UIColor(named: "gold")?.cgColor
    }
    
    // MARK: - Private methods
    
    private func setupImage(url: String, imageView: UIImageView) {
        let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(posterImageView.contentScaleFactor),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
    }
}
