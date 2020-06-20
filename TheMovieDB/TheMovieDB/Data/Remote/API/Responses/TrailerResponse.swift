//
//  TrailerResponse.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation


struct TrailerResponse: Codable {
    let results: [Trailer]
}

struct Trailer: Codable {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
}
