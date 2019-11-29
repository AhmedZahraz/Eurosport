//
//  ArticlesRepository.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Common

public protocol ArticlesRepository {
    @discardableResult
    func articlesList(with result: @escaping (Result<Articles, Error>) -> Void) -> Cancellable?
}
