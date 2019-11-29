//
//  DIContainer.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import UIKit
import Networking
import Common
import Presentation

class AppDIContainer {
    
    lazy var appConfigurations = AppConfigurations()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransfer = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfigurations.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(session: URLSession.shared,
                                                   config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
   
    // DIContainers of scenes
    func makeArticlesSceneDIContainer() -> ArticlesSceneDIContainer {
        let dependencies = ArticlesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return ArticlesSceneDIContainer(dependencies: dependencies)
    }
}

extension ArticlesSceneDIContainer: ArticlesListViewControllersFactory {}
