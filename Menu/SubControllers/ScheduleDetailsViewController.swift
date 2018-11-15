//
//  ScheduleDetailsViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/23/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var subjectLabel: UILabel?
    @IBOutlet weak var subjectValueLabel: UILabel?
    @IBOutlet weak var buildingLabel: UILabel?
    @IBOutlet weak var buildingValueLabel: UILabel?
    @IBOutlet weak var roomLabel: UILabel?
    @IBOutlet weak var roomValueLabel: UILabel?
    @IBOutlet weak var hourLabel: UILabel?
    @IBOutlet weak var hourValueLabel: UILabel?
    @IBOutlet weak var noLabel: UILabel?
    @IBOutlet weak var noValueLabel: UILabel?
    @IBOutlet weak var lectureLabel: UILabel?
    @IBOutlet weak var lectureValueLabel: UILabel?
    @IBOutlet weak var okButtonLabel: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func awakeFromNib() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        detailLabel?.text = "Detail".localized()
        subjectLabel?.text = "Subject".localized()
        buildingLabel?.text = "Building".localized()
        hourLabel?.text = "hour".localized()
        noLabel?.text = "Lesson".localized()
        lectureLabel?.text = "Lecture".localized()
        roomLabel?.text = "Room".localized()
        subjectLabel?.adjustsFontSizeToFitWidth = true
    }

    @IBAction func okButton(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
    }
}
