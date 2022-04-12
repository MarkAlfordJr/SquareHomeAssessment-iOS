//
//  UIImageViewExtension.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    // func to fetch image from URL, return url dataTask
    @discardableResult
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return nil
    }
}
