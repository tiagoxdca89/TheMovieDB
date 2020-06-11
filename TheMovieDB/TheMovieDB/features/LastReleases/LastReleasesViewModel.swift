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
}

class LastReleasesViewModel: BaseViewModel {
    
    var dataSource: Driver<[Movie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    
    let lastReleasesUseCase: LastReleasesUseCaseProtocol
    
    // MARK: - Private properties
    
    private var _dataSource = BehaviorSubject<[Movie]>(value: [])
    
    init(useCase: LastReleasesUseCaseProtocol) {
        self.lastReleasesUseCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        lastReleasesUseCase.getLastReleases()
            .subscribe(onSuccess: { [weak self] movies in
                guard let self = self else { return }
                self._dataSource.onNext(movies)
            }, onError: { (error: Error) in
                debugPrint("[ERROR] => \(error)")
            })
            .disposed(by: bag)
    }
    
}

extension LastReleasesViewModel: LastReleasesViewModelProtocol {}
