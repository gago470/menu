//
//  ScheduleTableHeder.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/21/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class ScheduleTableHeder: UITableViewCell {
    
    static var sharedInstacne_:ScheduleTableHeder?
    
    class var sharedInstance: ScheduleTableHeder {
        
        if sharedInstacne_ == nil {
            sharedInstacne_ = ScheduleTableHeder()
        }
        return sharedInstacne_!
    }
    

    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var LHLable: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var subjectLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        LHLable?.text = "l/h".localized()
        timeLabel?.text = "subject".localized()
        numberLabel?.text = "time".localized()
        subjectLabel?.text =  "N°".localized()
        
        setBorder()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func reloadView() {
        setNeedsLayout()
        layoutIfNeeded()
        
    }
    
    func setBorder() {
        
        LHLable?.layer.borderWidth = 0.5
        LHLable?.layer.cornerRadius = 0
        LHLable?.layer.borderColor = UIColor.lightGray.cgColor
        
        timeLabel?.layer.borderWidth = 0.5
        timeLabel?.layer.cornerRadius = 0
        timeLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        numberLabel?.layer.borderWidth = 0.5
        numberLabel?.layer.cornerRadius = 0
        numberLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        subjectLabel?.layer.borderWidth = 0.5
        subjectLabel?.layer.cornerRadius = 0
        subjectLabel?.layer.borderColor = UIColor.lightGray.cgColor
        
        dayLabel?.layer.borderWidth = 0.5
        dayLabel?.layer.cornerRadius = 0
        dayLabel?.layer.borderColor = UIColor.lightGray.cgColor
    }
}
