//
//  SubjectTableViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/30/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var exTypeLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fiilDataOFEachCell(subject: SubjectListOfSemester) {
        
        let currentLang = Localize.currentLanguage()
        switch currentLang {
        case "en":
            subjectNameLabel.text = subject.subjectName_en
            exTypeLabel.text = subject.exType_en
            break
        case "hy":
            subjectNameLabel.text = subject.subjectName_hy
            exTypeLabel.text = subject.exType_hy
            break
        case "ru":
            subjectNameLabel.text = subject.subjectName_ru
            exTypeLabel.text = subject.exType_ru
            break
        default:
            subjectNameLabel.text = subject.subjectName_en
            exTypeLabel.text = subject.exType_en
        }
        hourLabel.text = "\(subject.hours)"
        creditLabel.text = "\(subject.credit)"
    }
}
