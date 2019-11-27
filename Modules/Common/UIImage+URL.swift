//
//  UIImage+URL.swift
//  Common
//
//  Created by Ahmed Zahraz on 27/11/2019.
//

import Foundation

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            self.init(named: "image_not_found")
        }
    }
}
