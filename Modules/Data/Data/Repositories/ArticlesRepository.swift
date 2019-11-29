//
//  ArticlesRepository.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Common
import Domain
import Networking

public class DefaultArticlesRepository {
    
    private let dataTransferService: DataTransfer
    
    public init(dataTransferService: DataTransfer) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultArticlesRepository: ArticlesRepository {

    public func articlesList(with result: @escaping (Result<Articles, Error>) -> Void) -> Cancellable? {
        let endpoint = APIEndpoints.articles()
        
        return self.dataTransferService.request(with: endpoint) { (response: Result<ArticlesResponse, Error>) in
            switch response {
            case .success(let articlesResponse):
                result(.success(Articles.map(articlesResponse: articlesResponse).sorted(by: { $0.timestamp > $1.timestamp })))
                return
            case .failure(let error):
                result(.failure(error))
                return
            }
        }
    }
}
