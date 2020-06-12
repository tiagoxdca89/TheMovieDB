//
//  TopRatedUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol TopRatedUseCaseProtocol {
    func getTopRated() -> Single<[Movie]>
}

class TopRatedUseCase: TopRatedUseCaseProtocol {
    
    private let remoteDataSource: TopRatedRemoteDataSourceProtocol
    
    init(remoteDataSource: TopRatedRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTopRated() -> Single<[Movie]> {
        return remoteDataSource.getTopRated().map { $0.results }
    }
}
