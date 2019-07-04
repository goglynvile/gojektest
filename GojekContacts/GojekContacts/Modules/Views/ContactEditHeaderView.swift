//
//  ContactEditHeaderView.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactEditHeaderView: UITableViewHeaderFooterView {

    // MARK: Default values
    static let reuseIdentifier = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    // MARK: Public IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnImagePicker: UIButton!
    
    // MARK: Public properties
    weak var contactViewModel: ContactViewModel?
    
    // MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // customize UI components
        self.contentView.backgroundColor = .white
        Utility.addGradientToView(view: self.contentView, colorTop: .white, colorBottom: Constant.Color.green)
        Utility.roundImage(view: self.imgProfilePic)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func clickedImagePicker(_ sender: UIButton) {
    
    }
    
}
