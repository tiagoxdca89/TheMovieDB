//
//  DetailsViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var backdrop_img: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var lbl_subtitle: UILabel!
    @IBOutlet weak var lbl_year: UILabel!
    @IBOutlet weak var lbl_duration: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var btn_addFavorites: UIButton!
    
    var viewModel: DetailsViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    
    weak var coordinator: DetailsCoordinator?
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.movieDetail.asObservable()
            .subscribe(onNext: { [weak self] (movie: Movie) in
                self?.setupUI(movie: movie)
                }, onError: { (error: Error) in
                    debugPrint("[ERROR] = \(error.localizedDescription)")
            }).disposed(by: bag)
    }
}

extension DetailsViewController {
    
    fileprivate func setupUI(movie: Movie) {
        
        let posterURL = movie.getPosterEndPoint()
        let backdrop = movie.getBackDropURL()
        setupImage(url: posterURL, imageView: poster)
        setupImage(url: backdrop, imageView: backdrop_img)
        lbl_title.text = movie.title
        lbl_subtitle.text = movie.original_title
        lbl_year.text = movie.release_date
        lbl_duration.text = "\(movie.runtime ?? 0 / 60)"
        overview.text = movie.overview
        votes.text = "\(movie.vote_average)"
        categories.text = getGenders(genders: movie.genres)
        
    }
    
    fileprivate func getGenders(genders: [Genre]?) -> String {
        guard let _genders = genders else { return "" }
        var genders_String = ""
        _genders.forEach {
            genders_String.append("\($0.name ?? "") | ")
        }
        return genders_String
    }
    
    fileprivate func setupImage(url: String, imageView: UIImageView) {
        let processor = DownsamplingImageProcessor(size: poster.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: url),
            options: [
                .processor(processor),
                .scaleFactor(poster.contentScaleFactor),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
    }
}
