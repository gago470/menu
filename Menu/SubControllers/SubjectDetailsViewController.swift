//
//  SubjectDetailsViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/24/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class SubjectDetailsViewController: UIViewController {

    @IBOutlet weak var subjectName: UILabel?
    @IBOutlet weak var professionLabel: UILabel?
    @IBOutlet weak var semesterLabel: UILabel?
    @IBOutlet weak var studyLanguageLabel: UILabel?
    @IBOutlet weak var bySpecailityLabel: UILabel?
    @IBOutlet weak var subjectTypeLabel: UILabel?
    @IBOutlet weak var subjectTeachingTypeLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var creditLabel: UILabel?
    @IBOutlet weak var examinationTypeLabel: UILabel?
    
    
    @IBOutlet weak var professionValueLabel: UILabel?
    @IBOutlet weak var semesterValueLabel: UILabel?
    @IBOutlet weak var studyLanguageValueLabel: UILabel?
    @IBOutlet weak var bySpecialityValueLabel: UILabel?
    @IBOutlet weak var subjectTypeValueLabel: UILabel?
    @IBOutlet weak var subjectTeachingTypeValueLabel: UILabel?
    @IBOutlet weak var hoursValueLabel: UILabel?
    @IBOutlet weak var creditValueLabel: UILabel?
    @IBOutlet weak var examinationTypeValueLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        professionLabel?.text = "Profession".localized()
        semesterLabel?.text = "Semester".localized()
        studyLanguageLabel?.text = "Study language".localized()
        bySpecailityLabel?.text = "By specialty".localized()
        subjectTypeLabel?.text = "Subject type".localized()
        subjectTeachingTypeLabel?.text = "Subject teaching type".localized()
        hoursLabel?.text = "Hours".localized()
        creditLabel?.text = "Credit".localized()
        examinationTypeLabel?.text = "Examination type".localized()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
