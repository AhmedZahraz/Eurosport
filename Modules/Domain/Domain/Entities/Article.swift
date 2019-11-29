//
//  Article.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation

public typealias Articles = [Article]

public class Article {
    public let timestamp: Int64
    public let title: String
    public let image: String?
    public let category: String?
    
    public init(timestamp: Int64,
         title: String,
         image: String?,
         category: String?) {
        self.timestamp = timestamp
        self.title = title
        self.image = image
        self.category = category
    }
}
