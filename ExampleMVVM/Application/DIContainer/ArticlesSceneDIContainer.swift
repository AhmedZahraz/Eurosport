//
//  ArticlesSceneDIContainer.swift
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

class ArticlesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransfer
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    // MARK: - Use Cases
    func makeShowArticlesUseCase() -> ShowArticlesUseCase {
        return DefaultShowArticlesUseCase(articlesRepository: makeArticlesRepository())
    }
    
    // MARK: - Data Sources
    func makeArticlesRepository() -> ArticlesRepository {
        return DefaultArticlesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Articles List
    func makeArticlesListViewController() -> UIViewController {
        return ArticlesListViewController.create(with: makeArticlesListViewModel(), articlesListViewControllersFactory: self)
    }
    
    func makeArticlesListViewModel() -> ArticlesListViewModel {
        return ArticlesListViewModel(showArticlesUseCase: makeShowArticlesUseCase())
    }
    
    // MARK: - Article Details
    func makeArticleDetailsViewController(storyItem: ArticlesListViewModel.StoryItem) -> UIViewController {
        return ArticleDetailsViewController.create(with: makeArticleDetailsViewModel(storyItem: storyItem))
    }
    
    func makeArticleDetailsViewModel(storyItem: ArticlesListViewModel.StoryItem) -> ArticleDetailsViewModel {
        return ArticleDetailsViewModel(storyItem: storyItem)
    }
}
