//
//  MovieEndpoints.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Domain
import Networking

struct APIEndpoints {
    
    static func movies() -> DataEndpoint<ArticlesResponse> {
        
        return DataEndpoint(path: "bins/ug7oc")
    }
    
    static func moviePoster(path: String, width: Int) -> DataEndpoint<Data> {
        
        let sizes = [92, 185, 500, 780]
        let availableWidth = sizes.sorted().first { width <= $0 } ?? sizes.last
        return DataEndpoint(path: "t/p/w\(availableWidth!)\(path)")
    }
}
