//
//  AbsenceViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift


class AbsenceViewController: UIViewController {
    
    @IBOutlet weak var chartButton: UIButton?
    @IBOutlet weak var listButton: UIButton?
    @IBOutlet weak var baseBackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        baseBackView.layer.cornerRadius = 20
        listButton?.setTitle("  All semesters".localized(), for: .normal)
        chartButton?.setTitle(" Current semester".localized(), for: .normal)
        listButton?.setTitleColor(UIColor.black, for: .normal)
        chartButton?.setTitleColor(UIColor.black, for: .normal)
        
    
    
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        listButton?.setTitle("All semesters".localized(), for: .normal)
//        chartButton?.setTitle("Current semester".localized(), for: .normal)
//
//    }
    
    
    @IBAction func listButton(_ sender: UIButton) {
        let absenceListVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "AbsenceListViewControllerID") as?  AbsenceListViewController
        self.navigationController?.pushViewController(absenceListVC!, animated: true) 
    }
    
    @IBAction func chartButton(_ sender: UIButton) {
        let absenceChartVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "chartVCID") as? ChartViewController
        self.navigationController?.pushViewController(absenceChartVC!, animated: true)
    }
    
}
