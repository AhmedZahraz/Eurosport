//
//  MoviesSceneDIContainer.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 03.03.19.
//

import Foundation
import UIKit
import Domain
import Presentation
import Networking
import Data

class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransfer
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    //lazy var moviesQueriesStorage = DefaultMoviesQueriesStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }
    
//    func makeFetchMoviesRecentQueriesUseCase() -> FetchMoviesRecentQueriesUseCase {
//        return DefaultFetchMoviesRecentQueriesUseCase(moviesQueriesRepository: makeMoviesQueriesRepository())
//    }
    
    // MARK: - Data Sources
    func makeMoviesRepository() -> MoviesRepository {
        return DefaultMoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
//    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
//        return DefaultMoviesQueriesRepository(dataTransferService: dependencies.apiDataTransferService,
//                                              moviesQueriesPersistentStorage: moviesQueriesStorage)
//    }
//    func makePosterImagesRepository() -> PosterImagesRepository  {
//        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService,
//                                             imageNotFoundData: UIImage(named: "image_not_found")?.pngData())
//    }
    
    // MARK: - Movies List
    func makeMoviesListViewController() -> UIViewController {
        return MoviesListViewController.create(with: makeMoviesListViewModel(), moviesListViewControllersFactory: self)
    }
    
    func makeMoviesListViewModel() -> MoviesListViewModel {
        return MoviesListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase())
    }
    
    // MARK: - Movie Details
    func makeMoviesDetailsViewController(storyItem: MoviesListViewModel.StoryItem) -> UIViewController {
        return MovieDetailsViewController.create(with: makeMoviesDetailsViewModel(storyItem: storyItem))
    }
    
    func makeMoviesDetailsViewModel(storyItem: MoviesListViewModel.StoryItem) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(storyItem: storyItem)
    }
    
    // MARK: - Movies Queries Suggestions List
//    public func makeMoviesQueriesSuggestionsListViewController(delegate: MoviesQueryListViewModelDelegate) -> UIViewController {
//        let viewModel = makeMoviesQueryListViewModel(delegate: delegate)
//        return MoviesQueriesTableViewController.create(with: viewModel)
//    }
//
//    func makeMoviesQueryListViewModel(delegate: MoviesQueryListViewModelDelegate) -> MoviesQueryListViewModel {
//        return MoviesQueryListViewModel(numberOfQueriesToShow: 10,
//                                        fetchMoviesRecentQueriesUseCase: makeFetchMoviesRecentQueriesUseCase(),
//                                        delegate: delegate)
//    }
}
