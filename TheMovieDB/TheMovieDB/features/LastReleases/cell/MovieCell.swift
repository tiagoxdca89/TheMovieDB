//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseIdentifier = "MovieCell"
    var movie: Movie?
    
    func load(movie: Movie?) {
        self.movie = movie
        guard let stringURL = movie?.getPosterEndPoint() else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: stringURL),
            placeholder: UIImage(named: "placeholder"),
            options: [
                .scaleFactor(imageView.contentScaleFactor),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
    }
}
