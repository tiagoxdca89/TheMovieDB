//
//  LastReleasesViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift

class LastReleasesViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var viewModel: LastReleasesViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    var coordinator: LastReleasesCoordinator?
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        setupBinding()
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else { return }
        
        viewModel.dataSource.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: MovieCell.reuseIdentifier, cellType: MovieCell.self)) { row, movie, cell in
            cell.load(movie: movie)
        }.disposed(by: bag)
        
        collectionView.rx.setDelegate(self).disposed(by: bag)
        
        collectionView
            .rx
            .itemSelected
            .bind(to: viewModel.selectedIndexPath)
            .disposed(by: bag)
        
        viewModel.selectedMovie.asObservable()
            .subscribe(onNext: { [weak self] (movie) in
                self?.coordinator?.coordinateToDetail(movie: movie)
            })
            .disposed(by: bag)
        
    }
}

extension LastReleasesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 1.5
        return CGSize(width: width, height: height)
    }
}
