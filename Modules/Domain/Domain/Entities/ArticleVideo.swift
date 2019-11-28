//
//  ArticleVideo.swift
//  Domain
//
//  Created by Ahmed Zahraz on 28/11/2019.
//

import Foundation

public class ArticleVideo: Article {
    public let url: String?
    public let views: Int
    
    public init(timestamp: Int64,
                title: String,
                image: String?,
                url: String?,
                category: String?,
                views: Int) {
        self.url = url
        self.views = views
        super.init(timestamp: timestamp, title: title, image: image, category: category)
    }
}
