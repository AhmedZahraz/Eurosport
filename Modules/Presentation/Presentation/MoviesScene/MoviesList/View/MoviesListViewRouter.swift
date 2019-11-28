//
//  MoviesListViewRouter.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 05.03.19.
//

import Foundation
import UIKit
import AVKit

class DefaultMoviesListViewRouter: MoviesListViewRouter {

    weak var view: MoviesListViewController?
    let moviesListViewControllersFactory: MoviesListViewControllersFactory
    
    init(view: MoviesListViewController,
         moviesListViewControllersFactory: MoviesListViewControllersFactory) {
        self.view = view
        self.moviesListViewControllersFactory = moviesListViewControllersFactory
    }
    
    func perform(_ route: MoviesListViewRoute) {
        switch route {
        case .showStoryDetail(let storyItem):
            guard let view = view else { return }
            let vc = moviesListViewControllersFactory.makeMoviesDetailsViewController(storyItem: storyItem)
            view.navigationController?.present(vc, animated: true)
        case .playVideo(let videoPath):
            guard let view = view else { return }
            guard let url = URL(string: videoPath) else { return }
            let player = AVPlayer(url: url)
            let vc = AVPlayerViewController()
            vc.player = player
            
            view.navigationController?.present(vc, animated: true) {
                vc.player?.play()
            }
        }
    }
}

extension UIViewController {
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
