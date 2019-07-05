//
//  Constants.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    struct Color {
        static let green = UIColor(red: 81.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1)
    }
    struct Text {
        static let null = "Data fetched is null."
        static let imagePlaceholder = "placeholder_photo"
        static let allFields = "Please fill out all the fields"
        static let deleteContact = "Do you want to delete this contact?"
        
        static func successAdded(name: String) -> String {
            return "Successfully added \(name)"
        }
        static func successDeleted(name: String) -> String {
            return "Successfully deleted \(name)"
        }
    }
    struct App {
        static let name = "Contact"
    }

}
