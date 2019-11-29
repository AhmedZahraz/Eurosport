//
//  Article+Decodable.swift
//  ExampleMVVM
//
//  Created by Oleh on 22.09.18.
//

import Foundation
import Domain

public struct ArticlesResponse: Decodable {
    public let stories: [StoriesResponse]
    public let videos:  [VideosResponse]
    
    private enum CodingKeys: String, CodingKey {
        case stories
        case videos
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stories = try container.decode([StoriesResponse].self, forKey: .stories)
        self.videos = try container.decode([VideosResponse].self, forKey: .videos)
    }
}

public struct StoriesResponse: Decodable {
    public let timestamp: Int64
    public let title: String
    public let posterPath: String?
    public let intro: String?
    public let content: String?
    public let category: String?
    public let author: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case timestamp
        case title
        case posterPath = "image"
        case intro
        case content
        case category
        case author
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Int64.self, forKey: .timestamp)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.intro = try container.decodeIfPresent(String.self, forKey: .intro)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
    }
}

public struct VideosResponse: Decodable {
    public let timestamp: Int64
    public let title: String
    public let posterPath: String?
    public let videoPath: String?
    public let category: String?
    public let views: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case timestamp
        case title
        case posterPath = "image"
        case videoPath = "url"
        case category
        case views
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Int64.self, forKey: .timestamp)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.videoPath = try container.decodeIfPresent(String.self, forKey: .videoPath)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.views = try container.decodeIfPresent(Int.self, forKey: .views)
    }
}
