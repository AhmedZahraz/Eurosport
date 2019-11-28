//
//  MoviesListViewController.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import UIKit
import Common

public class MoviesListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var moviesListContainer: UIView!
    @IBOutlet weak private var loadingView: UIActivityIndicatorView!
    @IBOutlet weak private var emptyDataLabel: UILabel!
    
    public var viewModel: MoviesListViewModel!
    
    //private var moviesQueriesSuggestionsView: MoviesQueriesTableViewController?
    private var moviesTableViewController: MoviesListTableViewController?
    private var searchController = UISearchController(searchResultsController: nil)
    
    public class func create(with viewModel: MoviesListViewModel,
                      moviesListViewControllersFactory: MoviesListViewControllersFactory) -> MoviesListViewController {
        let view = instantiateViewController((Bundle(for: MoviesListViewController.self)))
        view.viewModel = viewModel
        view.viewModel.router = DefaultMoviesListViewRouter(view: view,
                                                            moviesListViewControllersFactory: moviesListViewControllersFactory)
        return view
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Home", comment: "")
        emptyDataLabel.text = NSLocalizedString("Search results ", comment: "")
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
    }
    
    public func bind(to viewModel: MoviesListViewModel) {
        viewModel.items.observe(on: self) { [unowned self] items in
            self.moviesTableViewController?.items = items
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
        if segue.identifier == String(describing: MoviesListTableViewController.self),
            let destinationVC = segue.destination as? MoviesListTableViewController {
            moviesTableViewController = destinationVC
            moviesTableViewController?.viewModel = viewModel
        }
    }

    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: error)
    }
    
    private func updateViewsVisibility(model: MoviesListViewModel) {
        loadingView.isHidden = true
        emptyDataLabel.isHidden = true
        moviesListContainer.isHidden = true
        moviesTableViewController?.update(isLoadingNextPage: false)
        
        if model.loadingType.value == .fullScreen {
            loadingView.isHidden = false
        } else if model.loadingType.value == .nextPage {
            moviesTableViewController?.update(isLoadingNextPage: true)
            moviesListContainer.isHidden = false
        } else if model.isEmpty {
            emptyDataLabel.isHidden = false
        } else {
            moviesListContainer.isHidden = false
        }
    }
}

// MARK: - MoviesListViewControllersFactory

public protocol MoviesListViewControllersFactory {
    
    func makeMoviesDetailsViewController(storyItem: MoviesListViewModel.StoryItem) -> UIViewController
}
