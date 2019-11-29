//
//  ArticlesListViewModelTests.swift
//  ExampleMVVMTests
//
//  Created by Oleh Kudinov on 17.08.19.
//

import XCTest
@testable import Presentation
import Domain
import Common

class ArticlesListViewModelTests: XCTestCase {
    
    private enum ShowArticlesUseCaseError: Error {
        case someError
    }

    let articles: Articles =  [
            Story(timestamp: 122, title: "title1", intro: "intro1", content: "content1", image: "/1", category: "tenis", author: "ahmed"),
            ArticleVideo.init(timestamp: 100, title: "title2", image: "/2", url: "/3", category: "foot", views: 123)
    ]

    class ShowArticlesUseCaseMock: ShowArticlesUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var articles: Articles = []

        func execute(completion: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(articles))
            }
            expectation?.fulfill()
            return nil
        }
    }

    func test_whenShowArticlesUseCaseRetrievesFirstPage_thenViewModelContainsOnlyFirstPage() {
        // given
        let showArticlesUseCaseMock = ShowArticlesUseCaseMock()
        showArticlesUseCaseMock.expectation = self.expectation(description: "contains only first page")
        showArticlesUseCaseMock.articles = articles
        let viewModel = ArticlesListViewModel(showArticlesUseCase: showArticlesUseCaseMock)
        // when
        viewModel.viewDidLoad()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.count, 2)
    }



    func test_whenShowArticlesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let showArticlesUseCaseMock = ShowArticlesUseCaseMock()
        showArticlesUseCaseMock.expectation = self.expectation(description: "contain errors")
        showArticlesUseCaseMock.error = ShowArticlesUseCaseError.someError
        let viewModel = ArticlesListViewModel(showArticlesUseCase: showArticlesUseCaseMock)
        // when
        viewModel.viewDidLoad()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}
