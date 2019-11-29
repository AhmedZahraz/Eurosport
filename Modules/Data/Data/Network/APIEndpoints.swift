//
//  APIEndpoints.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Domain
import Networking

struct APIEndpoints {
    
    static func articles() -> DataEndpoint<ArticlesResponse> {
        
        return DataEndpoint(path: "bins/ug7oc")
    }
}
