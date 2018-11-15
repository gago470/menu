//
//  SpetialityTableViewFooter.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 7/18/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class SpetialityTableViewFooter: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func otherButton(_ sender: UIButton) {
       NotificationCenter.default.post(name: Notification.Name(rawValue: "other Button"), object: nil)
    }
}
