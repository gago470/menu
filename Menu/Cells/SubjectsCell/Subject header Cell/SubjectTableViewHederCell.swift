//
//  SubjectTableViewHederCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/4/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class SubjectTableViewHederCell: UITableViewCell {

    @IBOutlet weak var semesterNum: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var exType: UILabel!
    @IBOutlet weak var hours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subject.text = "Subject".localized()
        credit.text = "Credit".localized()
        exType.text = "Ex.Type".localized()
        hours.text = "Hours".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
