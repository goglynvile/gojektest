//
//  ContactViewModel.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation
import UIKit

class ContactViewModel {
    let contact: Contact
    var image: UIImage?
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var fullName: String {
        if let fName = contact.firstName, let lName = contact.lastName {
            return "\(fName) \(lName)"
        }
        return ""
    }
    var imageUrl: String? {
        if contact.profilePic?.prefix(4) == "http" {
            return contact.profilePic
        }
        else {
            if let url = contact.profilePic {
                return Server.baseUrl + url
            }
        }
        
        return nil
    }
    var isFavorite: Bool {
        return contact.favorite ?? false
    }
    
    // MARK: Public methods
    func openMessenger() {
        if let phone = contact.phoneNumber, let url = URL(string: "sms:\(phone)")  {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    func openCall() {
        if let phone = contact.phoneNumber, let url = URL(string: "tel://\(phone)")  {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    func openEmail() {
        if let email = contact.email, let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}

