//
//  ContactEditHeaderView.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

protocol ContactEditHeaderViewDelegate {
    func didSelectPicker()
}
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
    var delegate: ContactEditHeaderViewDelegate?
    
    // MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // customize UI components
        self.contentView.backgroundColor = .white
        Utility.addGradientToView(view: self.contentView, colorTop: .white, colorBottom: Constant.Color.green)
        
        self.imgProfilePic.roundImage()
        self.imgProfilePic.addBorder(color: UIColor.white)
    }
    
    // MARK: IBActions
    @IBAction func clickedImagePicker(_ sender: UIButton) {
        self.delegate?.didSelectPicker()
    }
    
    // MARK: Public methods
    public func updateHeader(withImage image: UIImage?) {
        if let temp = image {
            self.imgProfilePic.image = temp
        }
        else {
            self.imgProfilePic.image = UIImage(named: Constant.Text.imagePlaceholder)
        }
    }
}
