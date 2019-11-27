//
//  Movie+Decodable.swift
//  ExampleMVVM
//
//  Created by Oleh on 22.09.18.
//

import Foundation
import Domain

public struct ArticlesResponse: Decodable {
    public let stories: [StoriesResponse]
    
    private enum CodingKeys: String, CodingKey {
        case stories
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stories = try container.decode([StoriesResponse].self, forKey: .stories)
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

fileprivate extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
