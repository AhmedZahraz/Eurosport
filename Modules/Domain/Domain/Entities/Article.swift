//
//  Movie.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation

public typealias MovieId = Int

public struct MoviesPage {
    public let articles: [Article]
    
    public init(articles: [Article]) {
        self.articles = articles
    }
}

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

//extension Movie: Hashable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
