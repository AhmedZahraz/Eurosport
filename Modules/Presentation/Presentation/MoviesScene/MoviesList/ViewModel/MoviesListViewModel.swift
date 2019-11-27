//
//  MoviesListViewModel.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Common
import Domain

public enum MoviesListViewRoute {
    case showMovieDetail(title: String, overview: String, posterPlaceholderImage: Data?, posterPath: String?)
    case showMovieQueriesSuggestions
    case closeMovieQueriesSuggestions
}

public protocol MoviesListViewRouter {
    func perform(_ segue: MoviesListViewRoute)
}

public class MoviesListViewModel {
    public enum LoadingType {
        case none
        case fullScreen
        case nextPage
    }
   
    public var router: MoviesListViewRouter?
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    public var isEmpty: Bool { return items.value.isEmpty }
    public private(set) var items: Observable<[Item]> = Observable([Item]())
    public private(set) var loadingType: Observable<LoadingType> = Observable(.none) { didSet { isLoading.value = loadingType.value != .none } }
    public private(set) var error: Observable<String> = Observable("")
    public private(set) var isLoading: Observable<Bool> = Observable(false)
    
    @discardableResult
    public init(searchMoviesUseCase: SearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    private func appendPage(moviesPage: MoviesPage) {
        self.items.value = items.value + moviesPage.articles.map{ MoviesListViewModel.Item(article: $0) }
    }
    
    private func resetPages() {
        items.value.removeAll()
    }
    
    private func load(loadingType: LoadingType) {
        self.loadingType.value = loadingType
        
        //let moviesRequest = SearchMoviesUseCaseRequestValue(query: movieQuery, page: 0)
        moviesLoadTask = searchMoviesUseCase.execute { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let moviesPage):
                strongSelf.appendPage(moviesPage: moviesPage)
            case .failure(let error):
                strongSelf.handle(error: error)
            }
            strongSelf.loadingType.value = .none
        }
    }
    
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading movies", comment: "")
    }    
}

// MARK: - INPUT. View event methods
extension MoviesListViewModel {
    
    public func viewDidLoad() {
        loadingType.value = .none
        load(loadingType: LoadingType.fullScreen)
    }
    
    public func didCancelSearch() {
        moviesLoadTask?.cancel()
    }

    public func showQueriesSuggestions() {
        router?.perform(.showMovieQueriesSuggestions)
    }
    
    public func closeQueriesSuggestions() {
        router?.perform(.closeMovieQueriesSuggestions)
    }
    
    public func didSelect(item: MoviesListViewModel.Item) {
        router?.perform(.showMovieDetail(title: item.title,
                                         overview: item.overview,
                                         posterPlaceholderImage: item.posterImage.value,
                                         posterPath: item.posterPath))
    }
}
