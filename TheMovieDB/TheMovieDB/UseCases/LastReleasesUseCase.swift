//
//  LastReleasesUseCaseProtocol.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol LastReleasesUseCaseProtocol {
    func getLastReleases() -> Single<[Movie]>
}

class LastReleasesUseCase: LastReleasesUseCaseProtocol {
    
    private let remoteDataSource: LastReleasesRemoteDataSourceProtocol
    
    init(remoteDataSource: LastReleasesRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getLastReleases() -> Single<[Movie]> {
        return remoteDataSource.getMovie().map { $0.results }
    }
    
}
