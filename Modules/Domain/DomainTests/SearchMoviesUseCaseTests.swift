//
//  SearchMoviesUseCaseTests.swift
//  CodeChallengeTests
//
//  Created by Oleh Kudinov on 01.10.18.
//

import XCTest
import Common
@testable import Domain

class SearchMoviesUseCaseTests: XCTestCase {

    static var moviesPages: [MoviesPage] {
        let page1 = MoviesPage(articles: [
            Article(timestamp: 1, title: "title1", image: "/1", category: "category1"),
            Article(timestamp: 2, title: "title2", image: "/2", category: "category2")])
        let page2 = MoviesPage(articles: [
            Article(timestamp: 3, title: "title3", image: "/3", category: "category3")])
        return [page1, page2]
    }

    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }

//    class MoviesQueriesRepositoryMock: MoviesQueriesRepository {
//        var recentQueries: [MovieQuery] = []
//        func recentsQueries(number: Int) -> [MovieQuery] {
//            return recentQueries
//        }
//        func saveRecentQuery(query: MovieQuery) {
//            recentQueries.append(query)
//        }
//    }
//
//    class MoviesRepositorySuccessMock: MoviesRepository {
//        func moviesList(query: MovieQuery, page: Int, with result: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
//            result(.success(SearchMoviesUseCaseTests.moviesPages[0]))
//            return nil
//        }
//    }
//
//    class MoviesRepositoryFailureMock: MoviesRepository {
//        func moviesList(query: MovieQuery, page: Int, with result: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
//            result(.failure(MoviesRepositorySuccessTestError.failedFetching))
//            return nil
//        }
//    }
//
//    func testSearchMoviesUseCase_whenSuccessfullyFetchesMoviesForQuery_thenQueryIsSavedInRecentQueries() {
//        // given
//        let expectation = self.expectation(description: "Recent query saved")
//        let moviesQueriesRepository = MoviesQueriesRepositoryMock()
//        let useCase = DefaultSearchMoviesUseCase(moviesRepository: MoviesRepositorySuccessMock(),
//                                                  moviesQueriesRepository: moviesQueriesRepository)
//
//        // when
//        let requestValue = SearchMoviesUseCaseRequestValue(query: MovieQuery(query: "title1"),
//                                                                                     page: 0)
//        _ = useCase.execute(requestValue: requestValue) { movies in
//            expectation.fulfill()
//        }
//        // then
//        waitForExpectations(timeout: 5, handler: nil)
//        XCTAssertTrue(moviesQueriesRepository.recentsQueries(number: 1).contains(MovieQuery(query: "title1")))
//    }
//
//    func testSearchMoviesUseCase_whenFailedFetchingMoviesForQuery_thenQueryIsNotSavedInRecentQueries() {
//        // given
//        let expectation = self.expectation(description: "Recent query saved")
//        let moviesQueriesRepository = MoviesQueriesRepositoryMock()
//        let useCase = DefaultSearchMoviesUseCase(moviesRepository: MoviesRepositoryFailureMock(),
//                                                moviesQueriesRepository: moviesQueriesRepository)
//
//        // when
//        let requestValue = SearchMoviesUseCaseRequestValue(query: MovieQuery(query: "title1"),
//                                                          page: 0)
//        _ = useCase.execute(requestValue: requestValue) { movies in
//            expectation.fulfill()
//        }
//        // then
//        waitForExpectations(timeout: 5, handler: nil)
//        XCTAssertTrue(moviesQueriesRepository.recentsQueries(number: 1).isEmpty)
//    }
}
