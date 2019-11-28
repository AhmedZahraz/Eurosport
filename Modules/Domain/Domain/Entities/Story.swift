//
//  Story.swift
//  Domain
//
//  Created by Ahmed Zahraz on 27/11/2019.
//

import Foundation

public class Story: Article {
    public let intro: String
    public let content: String?
    public let author: String
    
    public init(timestamp: Int64,
                title: String,
                intro: String?,
                content: String?,
                image: String?,
                category: String?,
                author: String?) {
        self.intro = intro ?? ""
        self.content = content
        self.author = author ?? ""
        super.init(timestamp: timestamp, title: title, image: image, category: category)
    }
}
