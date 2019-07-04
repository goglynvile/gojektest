//
//  Constants.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

class Constant {
    struct Server {
        static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
        static let contacts = "\(Constant.Server.baseUrl)/contacts.json"
    }
}
