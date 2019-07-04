//
//  ContactDetailHeaderView.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactDetailHeaderView: UITableViewHeaderFooterView {

    // MARK: Private properties IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    
    // MARK: Public properties
    weak var contactViewModel: ContactViewModel? {
        didSet {
            print("ContactDetailHeader oldValue: \(oldValue)")
        }
        willSet {
            print("ContactDetailHeader newValue: \(newValue)")
            if let newValue = newValue {
                 lblName.text = newValue.fullName
            }
        }
    }
    
    // MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // customize UI components
        self.contentView.backgroundColor = .white
        Utility.addGradientToView(view: self.contentView, colorTop: .white, colorBottom: Constant.Color.green)
        Utility.roundImage(view: self.imgProfilePic)

    }
    
    // MARK: private methods
    
    @IBAction func clickedMessage(_ sender: UIButton) {
    }
    @IBAction func clickedCall(_ sender: UIButton) {
    }
    @IBAction func clickedEmail(_ sender: UIButton) {
    }
    @IBAction func clickedFavourite(_ sender: UIButton) {
    }
    
}
