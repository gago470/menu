//
//  GradeDetailsViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 8/1/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class GradeDetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectValue: UILabel!
    @IBOutlet weak var exameDate: UILabel!
    @IBOutlet weak var exameDateValue: UILabel!
    @IBOutlet weak var atempteLabel: UILabel!
    @IBOutlet weak var atemptValue: UILabel!    
    @IBOutlet weak var okButtonOutlet: UIButton!
    var subjectValueText: String!
    var exameDateText: String!
    var atemptValueText: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       // super.navigationItem.hidesBackButton = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        detailsLabel?.text = "Detail".localized()
        subjectLabel?.text = "Subject".localized()
        exameDate?.text = "Exam date".localized()
        atempteLabel?.text = "Atempt".localized()
        okButtonOutlet?.setTitle("Ok".localized(), for: .normal)
        subjectValue.text = subjectValueText
        exameDateValue.text = exameDateText
        atemptValue.text = atemptValueText
    }
    
    
    
    
    @IBAction func okButtonAction(_ sender: UIButton) {

        parent?.navigationItem.hidesBackButton = false

        self.view.removeFromSuperview()
    }
}
