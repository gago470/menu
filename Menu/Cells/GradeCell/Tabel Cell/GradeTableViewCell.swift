//
//  GradeTableViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/30/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import RealmSwift


class GradeTableViewCell: UITableViewCell {
   
    @IBOutlet weak var gradeDateLabel: UILabel!
    @IBOutlet weak var gradeSubjectLabel: UILabel!
    @IBOutlet weak var gradeLexamLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBorderLabel()
    }

    
    func setBorderLabel() {
        
        gradeDateLabel?.layer.borderWidth = 0.3
        gradeDateLabel?.layer.cornerRadius = 0
        gradeDateLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        // label 2
        gradeSubjectLabel?.layer.borderWidth = 0.3
        gradeSubjectLabel?.layer.cornerRadius = 0
        gradeSubjectLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
      //  gradeLexamLabel?.layer.borderWidth = 0.5
        gradeLexamLabel?.layer.cornerRadius = gradeLexamLabel.frame.size.width/2
        gradeLexamLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        gradeMoreLabel?.layer.borderWidth = 0.3
        gradeMoreLabel?.layer.cornerRadius = 0
        gradeMoreLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        gradeLabel?.layer.borderWidth = 0.3
        gradeLabel?.layer.cornerRadius = gradeLabel.frame.size.width/2
        gradeLabel?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func feelGradeDataa (grade: GradeOfSemester){
        let date = NSDate(timeIntervalSince1970: (TimeInterval(grade.date)/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMMM. yyyy"
        dateFormatter.locale = Locale(identifier: Localize.currentLanguage())
        let dateString = dateFormatter.string(from: date as Date)
        gradeDateLabel.text = dateString
        let currentLang = Localize.currentLanguage()
        switch currentLang {
        case "en":
            gradeSubjectLabel.text = grade.subjectName_en
            break
        case "hy":
            gradeSubjectLabel.text = grade.subjectName_hy
            break
        case "ru":
            gradeSubjectLabel.text = grade.subjectName_ru
            break
        default:
            gradeSubjectLabel.text = grade.subjectName_en
        }
        if (grade.el_exam > 0 && grade.el_exam < 50) {
            gradeLexamLabel.backgroundColor = UIColor.red
        }else if (grade.el_exam > 50 && grade.el_exam < 70) {
            gradeLexamLabel.backgroundColor = UIColor.lightGray
        }else{
            gradeLexamLabel.backgroundColor = UIColor(red: 24/255, green: 204/255, blue: 0/255, alpha: 255/255)
        }
        gradeLexamLabel.text = String(grade.el_exam)
        if (grade.grade > 0 && grade.grade < 50) {
            gradeLabel.backgroundColor = UIColor.red
        }else if (grade.grade > 50 && grade.grade < 70) {
            gradeLabel.backgroundColor = UIColor.lightGray
        }else{
            gradeLabel.backgroundColor = UIColor(red: 24/255, green: 204/255, blue: 0/255, alpha: 1)
        }
        gradeLabel.text = String(grade.grade)
    }
}
