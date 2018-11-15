//
//  DatePopUpViewController.swift
//  NavigationDrawer
//
//  Created by AVROMIC on 12/5/17.
//  Copyright © 2017 e0000068. All rights reserved.
//

import UIKit
import Localize_Swift

class DatePopUpViewController: UIViewController {
    
    internal var dateString = ""
    
    //MARK: Pop up view outlets
    @IBOutlet weak var datePicker: UIDatePicker!
 
    @IBOutlet weak var okButton: UIButton!
  
    var onClickDateDone: ((_ dateString: String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // let dateLanguageCode = UserDefaults.standard.string(forKey: "datePickerLocale")
        datePicker.locale = Locale(identifier: Localize.currentLanguage())
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLayoutSubviews() {

       okButton.setTitle("Ok".localized(), for: .normal)
    }
    
    //MARK: - Pop up view buttons actions

    
    //   buttin for geting date
    @IBAction func okBottonAction(_ sender: Any) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yy"
        dateString = dateFormater.string(from: datePicker.date)
        if onClickDateDone != nil {
            onClickDateDone!(dateString)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.datePicker.reloadInputViews()
    }
}

