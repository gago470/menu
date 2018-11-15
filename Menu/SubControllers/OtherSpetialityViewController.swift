//
//  OtherSpetialityViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 7/18/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class OtherSpetialityViewController: UIViewController,UITextFieldDelegate {

    var otherSpetiality: ((_ dateString: String)->())?
    
    @IBOutlet weak var okButtonOutlet: UIButton!
    @IBOutlet weak var bottomConstrait: NSLayoutConstraint!
    @IBOutlet weak var othersTextFeald: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        othersTextFeald.delegate = self
        
        okButtonOutlet.setTitle("Ok".localized(), for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func textOkButton(_ sender: UIButton) {
        if otherSpetiality != nil {
            otherSpetiality!(othersTextFeald.text!)
        }
        self.view.removeFromSuperview()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if otherSpetiality != nil {
           otherSpetiality!(othersTextFeald.text!)
        }
        self.view.removeFromSuperview()
        return true
    }
}
