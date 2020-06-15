//
//  SearchCell.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var rate: UILabel!
    

    func setupCell(movie: Movie) {
        title.text = movie.title
        year.text = movie.release_date
        duration.text = "\(movie.runtime)"
        rate.text = "\(movie.vote_average)"
        setupImage(url: movie.getPosterEndPoint(), imageView: posterImageView)
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.borderColor = UIColor(named: "red")?.cgColor
    }
    
    private func setupImage(url: String, imageView: UIImageView) {
        let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: url),
            options: [
                .processor(processor),
                .scaleFactor(posterImageView.contentScaleFactor),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
    }
}