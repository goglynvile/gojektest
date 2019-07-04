//
//  UIImageView+Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

extension UIImageView {
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
                    self.image = data.toImage()
                    completion(data.toImage())
                }
                else {
                    self.image = placeholder
                    completion(placeholder)
                }
            }
        }
        
    }
}
