//
//  LastReleasesUseCaseProtocol.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

typealias ReleasesResult = (movies: [Movie], page: Int, totalPages: Int)

protocol LastReleasesUseCaseProtocol {
    func getLastReleases(page: Int) -> Single<ReleasesResult>
}

class LastReleasesUseCase: LastReleasesUseCaseProtocol {
    
    private let remoteDataSource: LastReleasesRemoteDataSourceProtocol
    
    init(remoteDataSource: LastReleasesRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getLastReleases(page: Int) -> Single<ReleasesResult> {
        return remoteDataSource.getMovies(page: page).map { ($0.results, $0.page, $0.total_pages) }
    }
}
