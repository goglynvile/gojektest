//
//  UIImageView+Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func roundImage() {
        self.layer.cornerRadius = self.frame.width / 2
    }
    func addBorder(color: UIColor) {
        self.layer.borderWidth = 3
        self.layer.borderColor = color.cgColor
    }
    func downloadImage(withPlaceholder placeholder: UIImage?, oldImage: UIImage?, url: String?, completion: @escaping (_ image: UIImage?) -> Void) {
        if let oldImage = oldImage {
            self.image = oldImage
            completion(oldImage)
        }
        else {
            self.image = placeholder
            guard let url = url else { return }
            DataManager.shared.downloadImage(url: url) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = data.toImage()
                    }
                    completion(data.toImage())
                }
                else {
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                    completion(placeholder)
                }
            }
        }
        
    }
}
