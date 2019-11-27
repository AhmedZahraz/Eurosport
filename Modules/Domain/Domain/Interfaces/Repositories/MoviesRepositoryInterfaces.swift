//
//  MoviesRepository.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import Common

public protocol MoviesRepository {
    @discardableResult
    func moviesList(with result: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
