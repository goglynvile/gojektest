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
    struct Server {
        static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
        static let contacts = "\(Constant.Server.baseUrl)/contacts.json"
        
        static func contact(id: Int) -> String {
            return "\(Constant.Server.baseUrl)/contacts/\(id).json"
        }
    }
    struct Color {
        static let green = UIColor(red: 81.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1)
    }
}
