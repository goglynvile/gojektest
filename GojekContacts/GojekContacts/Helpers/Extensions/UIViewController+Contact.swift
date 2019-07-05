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
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    func showAlert(title: String?, action: UIAlertAction, message: String?) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
    }
    func showAlertWithAction(title: String?, action: UIAlertAction, message: String?) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "  ", message: "  ", preferredStyle: .alert)
            //create an activity indicator
            let indicator = UIActivityIndicatorView(style: .whiteLarge)
            indicator.frame = alert.view.bounds
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            indicator.color = UIColor.black
            
            //add the activity indicator as a subview of the alert controller's view
            alert.view.addSubview(indicator)
            indicator.isUserInteractionEnabled = false
            indicator.startAnimating()
            
            alert.view.tag = 100
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func hideLoading() {
        DispatchQueue.main.async {
            if self.presentedViewController?.view.tag == 100 {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
