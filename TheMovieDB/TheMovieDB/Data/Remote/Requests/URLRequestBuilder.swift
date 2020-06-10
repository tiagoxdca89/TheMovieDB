//
//  URLRequestBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//


import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: URL? { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var method: RequestHTTPMethod { get }
    var urlRequest: URLRequest? { get }
    func asURLRequest() throws -> URLRequest
}
extension URLRequestBuilder {
    typealias RequestHTTPMethod = HTTPMethod
    var baseURL: URL? {
        return URL(string: API.baseUrl)
    }
    var headers: [String: String] {
        let header: [String: String] = [:]
        return header
    }
    var parameters: [String: Any]? {
        let param: [String: Any] = [:]
        return param
    }
    private var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    var method: HTTPMethod {
        return .get
    }
    var urlRequest: URLRequest? {
        guard let baseURL = baseURL?.appendingPathComponent(path) else {
            return nil
        }
        var urlRequest = URLRequest(url: baseURL)
        //Http method
        urlRequest.httpMethod = method.rawValue
        //Http headers
        urlRequest.allHTTPHeaderFields = headers
        // Common Headers
        urlRequest.setValue(API.HeaderValues.Json, forHTTPHeaderField: API.Headers.contentType)
        return urlRequest
    }
    func asURLRequest() throws -> URLRequest {
        guard let urlRequest = urlRequest else {
            fatalError("Couldn't have a valid URLRequest")
        }
        return try encoding.encode(urlRequest, with: parameters)
    }
}
