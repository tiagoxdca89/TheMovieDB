//
//  TopRatedUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Protocol

protocol TopRatedUseCaseProtocol {
    func getTopRated(page: Int) -> Single<MoviesResult>
}

// MARK: Class

class TopRatedUseCase: TopRatedUseCaseProtocol {
    
    private let remoteDataSource: TopRatedRemoteDataSourceProtocol
    
    // MARK: - Initialization
    
    init(remoteDataSource: TopRatedRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTopRated(page: Int) -> Single<MoviesResult> {
        return remoteDataSource.getTopRated(page: page).map { ($0.results, $0.page, $0.total_pages) }
    }
}
