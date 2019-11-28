//
//  MoviesListItemCell.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Foundation
import UIKit
import Common

class MoviesListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MoviesListItemCell.self)
    static let height = CGFloat(130)
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    
    var viewModel: MoviesListViewModel.Item!
    
    func fill(with item: MoviesListViewModel.Item) {
        self.viewModel = item
        posterImageView.load(from: item.posterPath, placeholder: UIImage(named: "placeholder_eurosport"))
        dateLabel.text = item.category.uppercased()
        titleLabel.text = item.title
        
        switch item {
        case is MoviesListViewModel.VideoItem:
            playImageView.isHidden = false
            let views = (item as? MoviesListViewModel.VideoItem)?.views ?? 0
            overviewLabel.text = "\(views) vues"
        case is MoviesListViewModel.StoryItem:
            playImageView.isHidden = true
            //
            let date = Date(timeIntervalSince1970: TimeInterval(item.timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            //
            let author = (item as? MoviesListViewModel.StoryItem)?.author ?? ""
            overviewLabel.text = "Par \(author) - \(strDate)"
        default:
            playImageView.isHidden = false
            overviewLabel.text = ""
        }
        
    }

}
