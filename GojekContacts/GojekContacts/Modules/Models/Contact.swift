//
//  Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

class Contact {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var profilePic: String?
    var favorite: Bool?
    
    // details
    var email: String?
    var phoneNumber: String?
    
    init(item: Dictionary<String, Any>) {
        self.id = item["id"] as? Int
        self.firstName = item["first_name"] as? String
        self.lastName = item["last_name"] as? String
        self.profilePic = item["profile_pic"] as? String
        self.favorite = item["favorite"] as? Bool
    }
    
    func update(item: Dictionary<String, Any>) {
        self.id = item["id"] as? Int
        self.firstName = item["first_name"] as? String
        self.lastName = item["last_name"] as? String
        self.profilePic = item["profile_pic"] as? String
        self.favorite = item["favorite"] as? Bool
        
        self.email = item["email"] as? String
        self.phoneNumber = item["phone_number"] as? String
    }
}
