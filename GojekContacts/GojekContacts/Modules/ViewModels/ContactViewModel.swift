//
//  ContactViewModel.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

class ContactViewModel {
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var fullName: String {
        if let fName = contact.firstName, let lName = contact.lastName {
            return "\(fName) \(lName)"
        }
        return ""
    }
    
    // MARK: Public methods
    func dictionaryValue() {

    }
}

