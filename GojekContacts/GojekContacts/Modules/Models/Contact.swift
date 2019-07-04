//
//  Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

class Contact {
    var id: Int
    var firstName: String
    var lastName: String
    var profilePic: String
    var favorite: Bool
    var url: String
    
    init(id: Int, firstName: String, lastName: String, profilePic: String, favorite: Bool, url: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePic = profilePic
        self.favorite = favorite
        self.url = url
    }
}
