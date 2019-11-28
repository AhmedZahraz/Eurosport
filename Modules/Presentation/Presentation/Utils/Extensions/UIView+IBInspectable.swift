//
//  UIView+IBInspectable.swift
//  Common
//
//  Created by Ahmed Zahraz on 28/11/2019.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
