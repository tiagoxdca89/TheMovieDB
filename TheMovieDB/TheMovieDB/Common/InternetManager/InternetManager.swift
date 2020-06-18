//
//  InternetManager.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 18/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import Alamofire


class InternetManager {
    
    static let shared = InternetManager()
    
    private init() {}
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
