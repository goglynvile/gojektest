//
//  ContactTableViewCell.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    // MARK: Public properties
    var contactViewModel: ContactViewModel? {
        willSet {
            if let newValue = newValue {
                lblName.text = newValue.fullName
                imgFavorite.isHidden = !(newValue.contact.favorite ?? false)
                
                imgProfilePic.downloadImage(withPlaceholder: UIImage(named: Constant.Text.imagePlaceholder), oldImage: newValue.image, url: newValue.imageUrl) { (image) in
                    self.contactViewModel?.image = image
                }
            }
        }
    }
    
    // MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgProfilePic.roundImage()
        self.imgProfilePic.addBorder(color: UIColor.white)
    }
}
