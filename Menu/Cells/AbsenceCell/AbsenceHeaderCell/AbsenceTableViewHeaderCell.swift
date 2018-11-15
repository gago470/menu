//
//  AbsenceTableViewHeaderCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/5/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class AbsenceTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    @IBOutlet weak var semesterAbsenceLabel: UILabel!
    
    @IBOutlet weak var semesterAbsenceCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        semesterAbsenceCountLabel.layer.cornerRadius = semesterAbsenceCountLabel.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
