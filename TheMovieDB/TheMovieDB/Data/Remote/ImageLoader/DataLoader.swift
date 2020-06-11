//
//  ImageLoader.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct DataLoader {
    
    static func getData(with urlString : String?) -> Data? {
        guard let url = URL(string: urlString ?? "") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
}
