//
//  ArticlesResponse+DomainMapping.swift
//  Data
//
//  Created by Oleh Kudinov on 12.08.19.
//  Copyright © 2019 Oleh Kudinov. All rights reserved.
//

import Foundation
import Domain

extension Articles {
    static func map(articlesResponse: ArticlesResponse) -> Articles {
        return articlesResponse.stories.map(Story.map) + articlesResponse.videos.map(ArticleVideo.map)
    }
}

extension Story {
    static func map(_ storyResponse: StoriesResponse) -> Story  {
        return Story(timestamp: storyResponse.timestamp, title: storyResponse.title, intro: storyResponse.intro, content: storyResponse.content, image: storyResponse.posterPath, category: storyResponse.category, author: storyResponse.author)
    }
}

extension ArticleVideo {
    static func map(_ videoResponse: VideosResponse) -> ArticleVideo  {
        return ArticleVideo(timestamp: videoResponse.timestamp, title: videoResponse.title, image: videoResponse.posterPath, url: videoResponse.videoPath, category: videoResponse.category, views: videoResponse.views ?? 0)
    }
}
