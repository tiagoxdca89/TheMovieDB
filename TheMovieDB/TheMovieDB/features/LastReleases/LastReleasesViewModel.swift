//
//  LastReleasesViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LastReleasesViewModelProtocol: BaseViewModelProtocol {
    var dataSource: Driver <[Movie]> { get }
    var selectedMovie: Driver<Movie> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get set }
    func viewWillAppear()
}

class LastReleasesViewModel: BaseViewModel {
    
    var dataSource: Driver<[Movie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    
    var selectedMovie: Driver<Movie> {
        return _selectedMovie.asDriver(onErrorJustReturn: Movie())
    }
    
    var selectedIndexPath = PublishSubject<IndexPath>()
    
    let lastReleasesUseCase: LastReleasesUseCaseProtocol
    
    // MARK: - Private properties
    
    private var _dataSource = BehaviorSubject<[Movie]>(value: [])
    private var _selectedMovie = PublishSubject<Movie>()
    
    init(useCase: LastReleasesUseCaseProtocol) {
        self.lastReleasesUseCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        getLastReleases()
    }
    
    private func setupBindings() {
        
        selectedIndexPath.map { $0.row }
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                let movies = (try? self._dataSource.value()) ?? []
                let movie = movies[index]
                self._selectedMovie.onNext(movie)
            }, onError: { (error: Error) in
                debugPrint("[Error] = \(error)")
            })
            .disposed(by: bag)
    }
    
    private func getLastReleases() {
        lastReleasesUseCase.getLastReleases()
        .subscribe(onSuccess: { [weak self] movies in
            guard let self = self else { return }
            self._dataSource.onNext(movies)
        }, onError: { [weak self] (error: Error) in
            self?.presentError(error: error)
            debugPrint("[ERROR] => \(error)")
        })
        .disposed(by: bag)
    }
    
}

extension LastReleasesViewModel: LastReleasesViewModelProtocol {}
