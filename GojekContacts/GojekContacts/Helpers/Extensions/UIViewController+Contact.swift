//
//  UIViewController+Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 05/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
