//
//  TrailerUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 14/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol TrailerUseCaseProtocol {
    func getTrailer(movieID: Int) -> Single<Trailer?>
}

class TrailerUseCase: TrailerUseCaseProtocol {
    
    private let remoteDataSource: TrailerRemoteDataSourceProtocol
    
    init(remoteDataSource: TrailerRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTrailer(movieID: Int) -> Single<Trailer?> {
        return remoteDataSource.getTrailer(movieID: movieID).map { $0.results.first }
    }
}
