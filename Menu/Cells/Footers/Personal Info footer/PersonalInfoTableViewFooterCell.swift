//
//  PersonalInfoTableViewFooterCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 6/20/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class PersonalInfoTableViewFooterCell: UITableViewCell {

    @IBOutlet weak var submiteButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func submiteEditeButton(_ sender: UIButton) {
       NotificationCenter.default.post(name: Notification.Name(rawValue: "submite Button"), object: nil)
    }
    
}
