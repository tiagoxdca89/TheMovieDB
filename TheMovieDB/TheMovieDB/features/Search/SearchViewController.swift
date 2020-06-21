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
    
    // MARK: - Private Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var imageEmpty: UIImageView?
    private let bag = DisposeBag()
    
    // MARK: - Public Properties
    
    var viewModel: SearchViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    var coordinator: SearchCoordinator?
    
    // MARK: - Overriden methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TOP RATED"
        setupEmptyImage()
        setupTableView()
        setupSearchController()
        viewModel?.viewDidLoad()
        setupBinding()
        showLoading(show: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    // MARK: - Private methods
    
    private func setupBinding() {
        guard let viewModel = viewModel else { return }
        
        viewModel.emptyList
            .asObservable()
            .subscribe(onNext: { [weak self] (empty) in
                self?.imageEmpty?.isHidden = !empty
                self?.showLoading(show: false)
            })
            .disposed(by: bag)
        
        viewModel.showLoading
            .asObservable()
            .subscribe(onNext: { [weak self] show in
                guard let self = self else { return }
                DispatchQueue.main.async { self.showLoading(show: show) }
            })
            .disposed(by: bag)
        
        viewModel
        .dataSource
        .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: SearchCell.reuseIdentifier,
                       cellType: SearchCell.self), curriedArgument: { (row, movie, cell) in
                        cell.setupCell(movie: movie)
                        self.showLoading(show: false)
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
    }
    
    private func setupTableView() {
        tableView.dataSource = nil
        tableView.tableFooterView = UIView()
    }
    
    private func setupEmptyImage() {
        imageEmpty = UIImageView(image: UIImage(named: "empty_yellow"))
        guard let imageEmpty = imageEmpty else { return }
        view.addSubview(imageEmpty)
        imageEmpty.isHidden = true
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        imageEmpty.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageEmpty.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            imageEmpty.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            imageEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])
        view.bringSubviewToFront(imageEmpty)
    }

}

    // MARK: - UISearchResultsUpdating, UISearchBarDelegate methods

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel?.searchBy(title: text)
        searchController.isActive = false
        showLoading(show: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.getTopRated()
    }
    
    func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if (indexPath.row == viewModel.moviesCount - 10) {
            viewModel.loadNextPage.onNext(())
        }
    }
}
