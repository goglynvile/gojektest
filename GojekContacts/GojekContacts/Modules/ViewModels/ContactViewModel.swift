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
        if let url = contact.profilePic {
            return Server.baseUrl + url
        }
        return nil
    }
    var isFavorite: Bool {
        return contact.favorite ?? false
    }
    
    // MARK: Public methods
    
}

