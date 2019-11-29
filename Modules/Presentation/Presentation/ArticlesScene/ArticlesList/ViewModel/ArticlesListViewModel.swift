//
//  ArticlesListViewModel.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Common
import Domain

public enum ArticlesListViewRoute {
    case showStoryDetail(storyItem: ArticlesListViewModel.StoryItem)
    case playVideo(url: String)
}

public protocol ArticlesListViewRouter {
    func perform(_ segue: ArticlesListViewRoute)
}

public class ArticlesListViewModel {
    public enum LoadingType {
        case none
        case fullScreen
        case nextPage
    }
   
    public var router: ArticlesListViewRouter?
    private let showArticlesUseCase: ShowArticlesUseCase
    
    private var articlesLoadTask: Cancellable? { willSet { articlesLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    public var isEmpty: Bool { return items.value.isEmpty }
    public private(set) var items: Observable<[Item]> = Observable([Item]())
    public private(set) var loadingType: Observable<LoadingType> = Observable(.none) { didSet { isLoading.value = loadingType.value != .none } }
    public private(set) var error: Observable<String> = Observable("")
    public private(set) var isLoading: Observable<Bool> = Observable(false)
    
    @discardableResult
    public init(showArticlesUseCase: ShowArticlesUseCase) {
        self.showArticlesUseCase = showArticlesUseCase
    }
    
    private func appendPage(articles: Articles) {
        self.items.value = items.value + articles.map{ ArticlesListViewModel.Item.map(article: $0) }
    }
    
    private func resetPages() {
        items.value.removeAll()
    }
    
    private func load(loadingType: LoadingType) {
        self.loadingType.value = loadingType
        
        articlesLoadTask = showArticlesUseCase.execute { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let articles):
                strongSelf.appendPage(articles: articles)
            case .failure(let error):
                strongSelf.handle(error: error)
            }
            strongSelf.loadingType.value = .none
        }
    }
    
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading articles", comment: "")
    }    
}

// MARK: - INPUT. View event methods
extension ArticlesListViewModel {
    
    public func viewDidLoad() {
        loadingType.value = .none
        load(loadingType: LoadingType.fullScreen)
    }
    
    public func didCancelSearch() {
        articlesLoadTask?.cancel()
    }
    
    public func didSelect(item: ArticlesListViewModel.Item) {
        if item is ArticlesListViewModel.VideoItem {
            router?.perform(.playVideo(url: (item as! ArticlesListViewModel.VideoItem).videoPath ?? ""))
        } else {
            router?.perform(.showStoryDetail(storyItem: (item as! ArticlesListViewModel.StoryItem)))
        }
    }
}
