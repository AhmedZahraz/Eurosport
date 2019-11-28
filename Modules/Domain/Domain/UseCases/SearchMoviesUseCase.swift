//
//  SearchMoviesUseCase.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 22.02.19.
//

import Foundation
import Common

public protocol SearchMoviesUseCase {
    func execute(completion: @escaping (Result<Articles, Error>) -> Void) -> Cancellable?
}

public class DefaultSearchMoviesUseCase: SearchMoviesUseCase {

    let moviesRepository: MoviesRepository
    
    public init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    public func execute(completion: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
        return moviesRepository.moviesList { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success:
                //strongSelf.moviesQueriesRepository.saveRecentQuery(query: requestValue.query)
                return completion(result)
            case .failure:
                return completion(result)
            }
        }
    }
}
