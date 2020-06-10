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

protocol RequestServiceProtocol {
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<T>
}

class RequestService: RequestServiceProtocol {
    
    static let shared = RequestService()
    private var sessionManager: Session = .default
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single<T>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            if RequestService.isConnectedToInternet {
                let request = self.sessionManager.request(urlConvertible)
                    .validate()
                    .responseJSON { response in
                        guard let _ = response.data else {
                            observer(.error(RemoteFetchError.parsingResponse))
                            return
                        }
                        switch response.result {
                        case .success:
                            debugPrint(response.request)
                            debugPrint(response.request?.allHTTPHeaderFields ?? "")
                            debugPrint(response)
                            guard let data = response.data else {
                                observer(.error(RemoteFetchError.parsingResponse))
                                return
                            }
                            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                                observer(.error(RemoteFetchError.decodingResponse))
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
                observer(.error(RemoteFetchError.networkNotAvailable))
                return Disposables.create()
            }
        }
    }
    
    
}
