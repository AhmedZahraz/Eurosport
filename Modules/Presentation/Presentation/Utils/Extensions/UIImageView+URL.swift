//
//  UIImage+URL.swift
//  Common
//
//  Created by Ahmed Zahraz on 28/11/2019.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func load(from path: String?, placeholder: UIImage?) {
        guard let strongPath = path else {
            self.image = placeholder
            return
        }
        self.sd_setImage(with: URL(string: strongPath), placeholderImage: placeholder)
    }
    
}
