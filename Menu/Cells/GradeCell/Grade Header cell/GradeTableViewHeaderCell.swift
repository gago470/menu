//
//  GradeTableViewHeaderCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/3/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class GradeTableViewHeaderCell: UITableViewCell {

    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var avarageGrade: UILabel!
    @IBOutlet weak var gradecountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var lXamLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = "Date".localized()
        subjectLabel.text = "Subject".localized()
        lXamLabel.text = "L.Xam".localized()
        gradeLabel.text = "Grade".localized()
        avarageGrade.text = "Avarage grade of semester".localized()
        gradecountLabel.layer.cornerRadius = gradecountLabel.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
}

