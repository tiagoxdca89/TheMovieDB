//
//  RemoteFetchError.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum GenericError: Error {
    case capturingSelf(entity: AnyObject)
    case invalidType
}
enum RemoteFetchError: Error {
    case url
    case taskError
    case noResponse
    case noData
    case decoding
    case responseStatusCode
    case invalidJSON
    case noInternet
}
