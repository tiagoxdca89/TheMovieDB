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
}
enum RemoteFetchError: Error, Equatable {
    case networkNotAvailable
    case parsingResponse
    case decodingResponse
    case notAuthorized
    case resourceNotFound
    case badRequestGeneric
    case unknown
}
