//
//  FavoriteCell.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 13/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    
    static let reuseIdentifier = "FavoriteCell"
    
    func setupCell(favorite: FavoriteMovie?) {
        guard let favorite = favorite else { return }
        title.text = favorite.title
        year.text = favorite.release_date
        if let imageData = favorite.poster {
            posterImageView.image = imageData as? UIImage
        } else {
           setupImage(url: "", imageView: posterImageView)
        }
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
