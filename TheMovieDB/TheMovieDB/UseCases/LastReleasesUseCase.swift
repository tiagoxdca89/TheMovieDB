//
//  LastReleasesUseCaseProtocol.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

typealias MoviesResult = (movies: [Movie], page: Int, totalPages: Int)

// MARK: Protocol

protocol LastReleasesUseCaseProtocol {
    func getLastReleases(page: Int) -> Single<MoviesResult>
}

// MARK: Class

class LastReleasesUseCase: LastReleasesUseCaseProtocol {
    
    private let remoteDataSource: LastReleasesRemoteDataSourceProtocol
    
    // MARK: - Initialization
    
    init(remoteDataSource: LastReleasesRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getLastReleases(page: Int) -> Single<MoviesResult> {
        return remoteDataSource.getMovies(page: page).map { ($0.results, $0.page, $0.total_pages) }
    }
}
