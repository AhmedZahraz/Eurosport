//
//  ShowArticlesUseCase.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 22.02.19.
//

import Foundation
import Common

public protocol ShowArticlesUseCase {
    func execute(completion: @escaping (Result<Articles, Error>) -> Void) -> Cancellable?
}

public class DefaultShowArticlesUseCase: ShowArticlesUseCase {

    let articlesRepository: ArticlesRepository
    
    public init(articlesRepository: ArticlesRepository) {
        self.articlesRepository = articlesRepository
    }
    
    public func execute(completion: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
        return articlesRepository.articlesList { result in
            switch result {
            case .success:
                return completion(result)
            case .failure:
                return completion(result)
            }
        }
    }
}
