//
//  ArticlesListViewRouter.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 05.03.19.
//

import Foundation
import UIKit
import AVKit

class DefaultArticlesListViewRouter: ArticlesListViewRouter {

    weak var view: ArticlesListViewController?
    let articlesListViewControllersFactory: ArticlesListViewControllersFactory
    
    init(view: ArticlesListViewController,
         articlesListViewControllersFactory: ArticlesListViewControllersFactory) {
        self.view = view
        self.articlesListViewControllersFactory = articlesListViewControllersFactory
    }
    
    func perform(_ route: ArticlesListViewRoute) {
        switch route {
        case .showStoryDetail(let storyItem):
            guard let view = view else { return }
            let vc = articlesListViewControllersFactory.makeArticleDetailsViewController(storyItem: storyItem)
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
