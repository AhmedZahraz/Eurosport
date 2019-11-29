//
//  ShowArticlesUseCaseTests.swift
//  CodeChallengeTests
//
//  Created by Oleh Kudinov on 01.10.18.
//

import XCTest
import Common
@testable import Domain

class ShowArticlesUseCaseTests: XCTestCase {
   
    static let articles: Articles =  [
        Story(timestamp: 122, title: "title1", intro: "intro1", content: "content1", image: "/1", category: "tenis", author: "ahmed"),
        ArticleVideo.init(timestamp: 100, title: "title2", image: "/2", url: "/3", category: "foot", views: 123)
    ]

    enum ArticlesRepositorySuccessTestError: Error {
        case failedFetching
    }

    class ArticlesRepositorySuccessMock: ArticlesRepository {
        func articlesList(with result: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
            result(.success(ShowArticlesUseCaseTests.articles))
            return nil
        }
    }

    class ArticlesRepositoryFailureMock: ArticlesRepository {
        func articlesList(with result: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
            result(.failure(ArticlesRepositorySuccessTestError.failedFetching))
            return nil
        }
    }

    func testShowArticlesUseCase_whenSuccessfullyFetchesArticles_thenResultContainesOneStoryAndOneArticleVideo() {
        // given
        let expectation = self.expectation(description: "One story and one articleVideo")
        var articlesResult: Articles? = nil
        let useCase = DefaultShowArticlesUseCase(articlesRepository: ArticlesRepositorySuccessMock())

        // when
        _ = useCase.execute { result in
            switch result {
            case .success(let articles):
                articlesResult = articles
            case .failure( _):
                articlesResult = nil
            }
            
            expectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(articlesResult?.count == 2)
        XCTAssertTrue(articlesResult?.contains(where: {$0 is Story}) ?? false)
        XCTAssertTrue(articlesResult?.contains(where: {$0 is ArticleVideo}) ?? false)
    }

    func testShowArticlesUseCase_whenFailedFetchingArticles_thenResultIsNil() {
        // given
        let expectation = self.expectation(description: "Failure")
        var articlesResult: Articles? = nil
        let useCase = DefaultShowArticlesUseCase(articlesRepository: ArticlesRepositoryFailureMock())

        // when
        _ = useCase.execute { result in
            switch result {
            case .success(let articles):
                articlesResult = articles
            case .failure( _):
                articlesResult = nil
            }
            expectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(articlesResult)
    }
}
