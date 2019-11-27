//
//  MoviesResponse+DomainMapping.swift
//  Data
//
//  Created by Oleh Kudinov on 12.08.19.
//  Copyright © 2019 Oleh Kudinov. All rights reserved.
//

import Foundation
import Domain

extension MoviesPage {
    static func map(moviesPage: ArticlesResponse) -> MoviesPage {
        return MoviesPage(articles: moviesPage.stories.map(Article.map))
    }
}

extension Article {
    static func map(_ story: StoriesResponse) -> Article  {
        return Article(timestamp: story.timestamp, title: story.title, image: story.posterPath, category: story.category)
    }
}
