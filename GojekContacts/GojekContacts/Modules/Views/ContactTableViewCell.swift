//
//  ContactTableViewCell.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    var contactViewModel: ContactViewModel? {
        willSet {
            if let newValue = newValue {
                lblName.text = newValue.fullName
                imgFavorite.isHidden = !(newValue.contact.favorite ?? false)
            }
        }
    }
}
