//
//  MoviesListViewItemModel.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 18.02.19.
//

import Foundation
import Common
import Domain

extension MoviesListViewModel {
    
    public class Item: Equatable {
        
        private(set) var id: Int64
        private(set) var posterPath: String?
        
        // MARK: - OUTPUT
        public let title: String
        public let overview: String
        public let releaseDate: String
        public private(set) var posterImage: Observable<Data?> = Observable(nil)
        
        private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

        init(article: Article) {
            self.id = article.timestamp
            self.title = article.title
            self.posterPath = article.image
            self.overview = article.category ?? ""
            //self.releaseDate = article.releaseDate != nil ? dateFormatter.string(from: movie.releaseDate!) : NSLocalizedString("To be announced", comment: "")
            self.releaseDate = "Test Ahmed"
        }
    }
}

// MARK: - INPUT. View event methods
extension MoviesListViewModel.Item {
    
    public func viewDidLoad() {}
    
    public func updatePosterImage(width: Int) {
        posterImage.value = nil
        guard let posterPath = posterPath else { return }
        guard let url = URL(string: posterPath) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            posterImage.value = data
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return
        }
//        imageLoadTask = posterImagesRepository.image(with: posterPath, width: width) { [weak self] result in
//            guard self?.posterPath == posterPath else { return }
//            switch result {
//            case .success(let data):
//                self?.posterImage.value = data
//            case .failure: break
//            }
//            self?.imageLoadTask = nil
//        }
    }
}

public func ==(lhs: MoviesListViewModel.Item, rhs: MoviesListViewModel.Item) -> Bool {
    return (lhs.id == rhs.id)
}

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
