//
//  SpetialityHeaderCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 7/23/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class SpetialityHeaderCell: UITableViewCell {
    
    var onButtonSelected : (() -> Void)? = nil

    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var openCloseButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func headerButton(_ sender: UIButton) {
    if let onButtonSelected = self.onButtonSelected {
            onButtonSelected()
        }
    }
}
