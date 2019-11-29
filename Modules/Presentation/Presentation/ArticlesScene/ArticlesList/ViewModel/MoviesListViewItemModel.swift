//
//  ArticlesListViewItemModel.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 18.02.19.
//

import Foundation
import Common
import Domain

extension ArticlesListViewModel {
   
    public class Item: Equatable {
        
        private(set) var timestamp: Int64
        private(set) var title: String
        private(set) var posterPath: String?
        private(set) var category: String
       
        private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

        init(article: Article) {
            self.timestamp = article.timestamp
            self.title = article.title
            self.posterPath = article.image
            self.category = article.category ?? ""
        }
    }
    
    public class StoryItem: Item {
        private(set) var intro: String?
        private(set) var content: String?
        private(set) var author: String?
        
        init(story: Story) {
            self.intro = story.intro
            self.content = story.content
            self.author = story.author
            super.init(article: story)
        }
    }
    
    public class VideoItem: Item {
        private(set) var videoPath: String?
        private(set) var views: Int
        
        init(articleVideo: ArticleVideo) {
            self.videoPath = articleVideo.url
            self.views = articleVideo.views
            super.init(article: articleVideo)
        }
    }
}

extension ArticlesListViewModel.Item {
    static func map(article: Article) -> ArticlesListViewModel.Item {
        switch article {
        case is Story:
            return ArticlesListViewModel.StoryItem.init(story: article as! Story)
        case is ArticleVideo:
            return ArticlesListViewModel.VideoItem.init(articleVideo: article as! ArticleVideo)
        default:
            return ArticlesListViewModel.Item.init(article: article)
        }
        
    }
}

public func ==(lhs: ArticlesListViewModel.Item, rhs: ArticlesListViewModel.Item) -> Bool {
    return (lhs.timestamp == rhs.timestamp)
}

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
