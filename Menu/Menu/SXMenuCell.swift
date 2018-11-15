//
//  SXMenuCell.swift
//  SixelConsultig
//
//  Created by My Mac on 10/30/17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import UIKit

class SXMenuCell: UITableViewCell {

    @IBOutlet weak var menuIcon: UIImageView?
    @IBOutlet weak var menuTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
