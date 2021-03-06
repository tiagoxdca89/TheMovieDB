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

// MARK: - Class

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
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
    
    // MARK: - Public properties
    
    var viewModel: DetailsViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    var coordinator: DetailsCoordinator?
    
    // MARK: - Private Properties
    
    private let bag = DisposeBag()

    // MARK: - Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading(show: true)
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.movieDetail.asObservable()
            .subscribe(onNext: { [weak self] (movie: Movie) in
                self?.setupUI(movie: movie)
                }).disposed(by: bag)
        
        viewModel.trailerURLString.asObservable()
            .subscribe(onNext: { [weak self] urlString in
                guard let self = self else { return }
                self.coordinator?.openSafari(controller: self, urlString: urlString)
            })
            .disposed(by: bag)
        
        btnPlay
            .rx
            .tap
            .asObservable()
            .subscribe(onNext: { _ in
                viewModel.getTrailer()
            })
            .disposed(by: bag)
        
        btn_addFavorites.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                let posterData = self?.poster.image?.pngData()
                let backDropData = self?.backdrop_img.image?.pngData()
                viewModel.saveToFavorites(poster: posterData, backDrop: backDropData)
                self?.btn_addFavorites.isEnabled = false
            })
            .disposed(by: bag)
    }
}

extension DetailsViewController {
    
    // MARK: - Private methods (extensions)
    
    private func setupUI(movie: Movie) {
        
        let posterURL = movie.getPosterEndPoint()
        poster.layer.borderColor = UIColor(named: "gold")?.cgColor
        poster.layer.borderWidth = 2.0
        let backdrop = movie.getBackDropURL()
        setupImage(movie: movie, url: posterURL, imageView: poster)
        setupImage(movie: movie, url: backdrop, imageView: backdrop_img)
        lbl_title.text = movie.title
        lbl_subtitle.text = "\(movie.original_title ?? "") (original title)"
        lbl_year.text = String(movie.release_date?.prefix(4) ?? "")
        let movieMinutes = minutesToHoursMinutes(minutes: movie.runtime ?? 0)
        lbl_duration.text = "\(movieMinutes.hours)h \(movieMinutes.leftMinutes)m"
        overview.text = movie.overview
        votes.text = "\(movie.vote_average ?? 0.0) / 10"
        categories.text = getGenders(genders: movie.genres)
        
        btn_addFavorites.layer.cornerRadius = 10
        btn_addFavorites.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    private func getGenders(genders: [GenreModel]?) -> String {
        guard let _genders = genders else { return "" }
        var genders_String = ""
        _genders.forEach {
            genders_String.append(" | \($0.name ?? "")")
        }
        let gendersString = genders_String.deletingPrefix(" | ")
        return gendersString
    }
    
    private func setupImage(movie: Movie, url: String, imageView: UIImageView) {
        if let dataBackDrop = movie.backdrop, let posterData = movie.poster {
            backdrop_img.image = UIImage(data: dataBackDrop)
            poster.image = UIImage(data: posterData)
            showLoading(show: false)
            return
        }
        let processor = DownsamplingImageProcessor(size: poster.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(poster.contentScaleFactor),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
        showLoading(show: false)
    }
}
