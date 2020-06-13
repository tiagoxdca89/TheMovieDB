//
//  SearchViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    var coordinator: SearchCoordinator?
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        viewModel?.viewDidLoad()
        
        setupBinding()
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else { return }
        
        viewModel
        .dataSource
        .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: SearchCell.reuseIdentifier,
                       cellType: SearchCell.self), curriedArgument: { (row, movie, cell) in
                        cell.setupCell(movie: movie)
        })
        .disposed(by: bag)
        
        tableView
            .rx
            .itemSelected
            .bind(to: viewModel.selectedIndexPath)
            .disposed(by: bag)
        
        viewModel.selectedMovie.asObservable()
            .subscribe(onNext: { [weak self] (movie) in
                self?.coordinator?.coordinateToDetail(movie: movie)
            })
            .disposed(by: bag)
        
        viewModel.selectedIndexPath
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
            })
            .disposed(by: bag)
    }
    
    private func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.tableFooterView = UIView()
    }

}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel?.searchBy(title: text)
        searchController.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.getTopRated()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barTintColor = .black
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
