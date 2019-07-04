//
//  ContactDetailHeaderView.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

protocol ContactDetailHeaderViewDelegate {
    func didSelectFavorite(contactViewModel: ContactViewModel)
}
class ContactDetailHeaderView: UITableViewHeaderFooterView {

    // MARK: Default values
    static let reuseIdentifier = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    // MARK: Public IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    
    // MARK: Public properties
    weak var contactViewModel: ContactViewModel? {
        willSet {
            if let newValue = newValue {
                lblName.text = newValue.fullName

                btnFavourite.setImage(UIImage(named: newValue.isFavorite ? "favourite_button_selected" : "favourite_button"), for: .normal)
                
                imgProfilePic.downloadImage(withPlaceholder: UIImage(named: Constant.Text.imagePlaceholder), oldImage: newValue.image, url: newValue.imageUrl) { (image) in
                    self.contactViewModel?.image = image
                }
                
            }
        }
    }
    var delegate: ContactDetailHeaderViewDelegate?
    
    // MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()

        // customize UI components
        self.contentView.backgroundColor = .white
        Utility.addGradientToView(view: self.contentView, colorTop: .white, colorBottom: Constant.Color.green)
        Utility.roundImage(view: self.imgProfilePic)
    }
    
    // MARK: Private methods
    private func updateFavoriteButton() {
        DispatchQueue.main.async {
            let fav = self.contactViewModel?.isFavorite ?? false
            self.btnFavourite.setImage(UIImage(named: fav ? "favourite_button_selected" : "favourite_button"), for: .normal)
        }
    }
    
    // MARK: IBActions
    @IBAction func clickedMessage(_ sender: UIButton) {
    }
    @IBAction func clickedCall(_ sender: UIButton) {
    }
    @IBAction func clickedEmail(_ sender: UIButton) {
    }
    @IBAction func clickedFavourite(_ sender: UIButton) {
        
        guard let cViewModel = contactViewModel else { return }
        self.delegate?.didSelectFavorite(contactViewModel: cViewModel)
    }
    
    
    
}
