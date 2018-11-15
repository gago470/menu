//
//  ScheduleTableViewCell.swift
//  Menu
//
//  Created by AVROMIC on 4/11/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var subjectLabel: UILabel?
    @IBOutlet weak var LHLable: UILabel?
    var color = UIColor(red: 163, green: 170, blue: 174, alpha: 55).cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorderLabel()
        
    }
    
    func setBorderLabel() {
        
        numberLabel?.layer.borderWidth = 0.5
        numberLabel?.layer.cornerRadius = 0
        numberLabel?.layer.borderColor = color
        
        // label 2
        timeLabel?.layer.borderWidth = 0.5
        timeLabel?.layer.cornerRadius = 0
        timeLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        subjectLabel?.layer.borderWidth = 0.5
        subjectLabel?.layer.cornerRadius = 0
        subjectLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        LHLable?.layer.borderWidth = 0.5
        LHLable?.layer.cornerRadius = 0
        LHLable?.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func fiilDataOFEachCell(lesson: Lesson) {
        let currentLang = Localize.currentLanguage()
        if currentLang == "ru" {
            subjectLabel?.text = lesson.subjectName_ru
        } else if currentLang == "hy" {
            subjectLabel?.text = lesson.subjectName_hy
        }else {
           subjectLabel?.text = lesson.subjectName_en
        }

        numberLabel?.text = lesson.number
        timeLabel?.text = lesson.hour        
        LHLable?.text = lesson.room
    }
    
    func fillDataforTouchOFEachCell(lesson: Lesson) {
    }
}
