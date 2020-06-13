//
//  FavoritesViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: FavoritesViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    let bag = DisposeBag()
    var coordinator: FavoritesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else { return }
        
        tableView.rx.setDelegate(self)
        .disposed(by: bag)
        
        tableView.rx.itemDeleted.bind(to: viewModel.deleteOnIndexPath)
        .disposed(by: bag)
        
        viewModel
        .dataSource
        .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: FavoriteCell.reuseIdentifier,
                       cellType: FavoriteCell.self), curriedArgument: { (row, movie, cell) in
                        cell.setupCell(favorite: movie)
        })
        .disposed(by: bag)
        
        tableView
            .rx
            .itemSelected
            .bind(to: viewModel.selectedIndexPath)
            .disposed(by: bag)
        
        viewModel.selectedMovie.asObservable()
            .subscribe(onNext: { [weak self] (favorite) in
                print("\(favorite)")
                let movie = viewModel.convertMovie(favorite: favorite)
                self?.coordinator?.coordinateToDetail(movie: movie)
            })
            .disposed(by: bag)
        
        viewModel.selectedIndexPath
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
            })
            .disposed(by: bag)
        
        viewModel.indexToDelete.asObservable()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deleteRows(at: [indexPath], with: .left)
            }, onError: { (error: Error) in
                debugPrint("\(error.localizedDescription)")
            })
            .disposed(by: bag)
    }

}

extension FavoritesViewController: UITableViewDelegate {
    
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Row deleted")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
