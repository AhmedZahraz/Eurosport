//
//  ArticleDetailsViewController.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 04.08.19.
//  Copyright (c) 2019 Company All rights reserved.
//

import UIKit
import Common

public class ArticleDetailsViewController: UIViewController, StoryboardInstantiable {
    
    private let fadeTransitionDuration: CFTimeInterval = 0.4
    
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: PaddingLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    public var viewModel: ArticleDetailsViewModel!
    
    public class func create(with viewModel: ArticleDetailsViewModel) -> ArticleDetailsViewController {
        let view = instantiateViewController(Bundle(for: ArticleDetailsViewController.self))
        view.viewModel = viewModel
        return view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
       
        view.accessibilityLabel = NSLocalizedString("Story details view", comment: "")
    }
    
    public func bind(to viewModel: ArticleDetailsViewModel) {
        viewModel.posterPath.observe(on: self) { [unowned self] path in
            self.posterImageView.load(from: path, placeholder: UIImage.init(named: "placeholder_eurosport"))
        }
        viewModel.category.observe(on: self) { [unowned self] text in
            self.categoryLabel.text = text
        }
        viewModel.title.observe(on: self) { [unowned self] text in
            self.titleLabel.text = text
        }
        viewModel.author.observe(on: self) { [unowned self] text in
            self.authorLabel.text = text
        }
        viewModel.description.observe(on: self) { [unowned self] text in
            self.descriptionLabel.text = text
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let text = descriptionLabel.text
        let shareAll: [Any] = [text ?? "Eurosport"]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
