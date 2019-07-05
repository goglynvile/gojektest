//
//  PreloadingTableViewCell.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 05/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class PreloadingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSkeleton: UIImageView!
    @IBOutlet weak var lblSkeleton: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.imgSkeleton.roundImage()
        self.imgSkeleton.addBorder(color: UIColor.white)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imgSkeleton.alpha = 0.8
            self.lblSkeleton.alpha = 0.8
        }, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
