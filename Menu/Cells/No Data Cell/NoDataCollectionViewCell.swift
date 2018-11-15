//
//  NoDataCollectionViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 8/31/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class NoDataCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        noDataLabel.text = "No information.".localized()
        // Initialization code
    }

}
