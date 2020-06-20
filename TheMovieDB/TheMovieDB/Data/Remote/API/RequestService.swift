//
//  RequestService.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

// MARK: Protocol

protocol RequestServiceProtocol {
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<T>
}

// MARK: - Class

class RequestService: RequestServiceProtocol {
    
    // MARK: - Private properties
    
    private var sessionManager: Session = .default
    
    // MARK: - Public properties
    
    static let shared = RequestService()
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    // MARK: - Public methods
    
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            if RequestService.isConnectedToInternet {
                let request = self.sessionManager.request(urlConvertible)
                    .validate()
                    .responseJSON { response in
                        guard let data = response.data else {
                            observer(.error(RemoteFetchError.noData))
                            return
                        }
                        switch response.result {
                        case .success:
                            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                                observer(.error(RemoteFetchError.decoding))
                                return
                            }
                            observer(.success(value))
                        case .failure(let error):
                            observer(.error(error))
                        }
                }
                return Disposables.create {
                    request.cancel()
                }
            } else {
                observer(.error(RemoteFetchError.noInternet))
                return Disposables.create()
            }
        }
    }
}
