//
//  ImageViewHelper.swift
//  AppleMusicSampleProject
//
//  Created by Brian King on 5/16/21.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImage(from urlString: String) {
        if let _image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = _image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

