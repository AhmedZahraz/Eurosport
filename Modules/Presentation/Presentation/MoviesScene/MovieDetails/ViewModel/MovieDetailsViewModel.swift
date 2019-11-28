//
//  MovieDetailsViewModel.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 04.08.19.
//  Copyright (c) 2019 Company All rights reserved.
//

import Foundation
import Common
import Domain

public class MovieDetailsViewModel {
    
    
    
    // MARK: - OUTPUT
    public private(set) var posterPath: Observable<String?> = Observable("")
    public private(set) var title: Observable<String> = Observable("")
    public private(set) var category: Observable<String> = Observable("")
    public private(set) var author: Observable<String> = Observable("")
    public private(set) var description: Observable<String> = Observable("")
    
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private var alreadyLoadedImageWidth: Int?
    
    public init(storyItem: MoviesListViewModel.StoryItem) {
        self.title.value = storyItem.title
        
        //
        let date = Date(timeIntervalSince1970: TimeInterval(storyItem.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        //
        let author = storyItem.author ?? ""
        self.author.value = "Par \(author) - \(strDate)"

        self.posterPath.value = storyItem.posterPath
        self.category.value = storyItem.category.uppercased()
        self.description.value = (storyItem.intro ?? "") + "\n" + (storyItem.content ?? "")
    }
}
