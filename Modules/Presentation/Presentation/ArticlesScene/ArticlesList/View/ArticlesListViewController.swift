//
//  ArticlesListViewController.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import UIKit
import Common

public class ArticlesListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var articlesListContainer: UIView!
    @IBOutlet weak private var loadingView: UIActivityIndicatorView!
    @IBOutlet weak private var emptyDataLabel: UILabel!
    
    public var viewModel: ArticlesListViewModel!
    
    private var articlesTableViewController: ArticlesListTableViewController?
    private var searchController = UISearchController(searchResultsController: nil)
    
    public class func create(with viewModel: ArticlesListViewModel,
                      articlesListViewControllersFactory: ArticlesListViewControllersFactory) -> ArticlesListViewController {
        let view = instantiateViewController((Bundle(for: ArticlesListViewController.self)))
        view.viewModel = viewModel
        view.viewModel.router = DefaultArticlesListViewRouter(view: view,
                                                              articlesListViewControllersFactory: articlesListViewControllersFactory)
        return view
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Accueil", comment: "")
        emptyDataLabel.text = NSLocalizedString("Search results ", comment: "")
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
    }
    
    public func bind(to viewModel: ArticlesListViewModel) {
        viewModel.items.observe(on: self) { [unowned self] items in
            self.articlesTableViewController?.items = items
            self.updateViewsVisibility(model: self.viewModel)
        }
        viewModel.error.observe(on: self) { [unowned self] error in
            self.showError(error)
        }
        viewModel.loadingType.observe(on: self) { [unowned self] _ in
            self.updateViewsVisibility(model: self.viewModel)
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
   
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: ArticlesListTableViewController.self),
            let destinationVC = segue.destination as? ArticlesListTableViewController {
            articlesTableViewController = destinationVC
            articlesTableViewController?.viewModel = viewModel
        }
    }

    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: error)
    }
    
    private func updateViewsVisibility(model: ArticlesListViewModel) {
        loadingView.isHidden = true
        emptyDataLabel.isHidden = true
        articlesListContainer.isHidden = true
        articlesTableViewController?.update(isLoadingNextPage: false)
        
        if model.loadingType.value == .fullScreen {
            loadingView.isHidden = false
        } else if model.loadingType.value == .nextPage {
            articlesTableViewController?.update(isLoadingNextPage: true)
            articlesListContainer.isHidden = false
        } else if model.isEmpty {
            emptyDataLabel.isHidden = false
        } else {
            articlesListContainer.isHidden = false
        }
    }
}

// MARK: - ArticlesListViewControllersFactory

public protocol ArticlesListViewControllersFactory {
    
    func makeArticleDetailsViewController(storyItem: ArticlesListViewModel.StoryItem) -> UIViewController
}
