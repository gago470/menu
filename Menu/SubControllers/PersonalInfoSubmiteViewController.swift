//
//  PersonalInfoSubmiteViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 6/19/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import Toast_Swift


class PersonalInfoSubmiteViewController: UIViewController,DatePickerViewDelegate, DataPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var doYouHaveLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yessLabel: UILabel!
    @IBOutlet weak var medicalSpecialityLabel: UILabel!
    @IBOutlet weak var choosenLabel: UILabel!
    @IBOutlet weak var otherInterestTextFeald: UITextField!
    @IBOutlet weak var otherInterestLabel: UILabel!
    
    @IBOutlet weak var occupationSwitch: UISwitch!
    @IBOutlet weak var chooseButtonOutlet: UIButton!
    @IBOutlet weak var submiteButtonOutlet: UIButton!
    var otherInterestTextInDB = DatabaseManager.sharedInstance.currentInfo?.personalData
    
    var indexesForSend = [Int]()
    var customSpetiality = [String]()
    var swichStatus = Bool()
    var preferrence = String()
    var finalDictionary = Dictionary<String, Any>()
    
    var languages = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        occupationSwitch.isOn = (otherInterestTextInDB?.ocupation) ?? false
        otherInterestTextFeald.delegate = self
        doYouHaveLabel.text = "Do you have regular occupation?".localized()
        yessLabel.text = "Yes".localized()
        noLabel.text = "No".localized()
        medicalSpecialityLabel.text = "Medical specialties of interest".localized()
        otherInterestTextFeald.placeholder = "Other interests / preferences".localized()
        otherInterestLabel.text = "Other interests / preferences".localized()
        chooseButtonOutlet.setTitle("Choose / Watch".localized(), for: .normal)
        submiteButtonOutlet.setTitle("Submite personal data".localized(), for: .normal)
        otherInterestTextFeald.text = otherInterestTextInDB?.interest
        
       
        populateProfesion()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    
   
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            swichStatus = true
        }else {
            swichStatus = false
        }
    }
    @IBAction func submiteButtonAction(_ sender: UIButton) {
        finalDictionary.updateValue(indexesForSend, forKey: "medicalSpecialitiesByIndex")
        finalDictionary.updateValue(customSpetiality, forKey: "otherSpeciality")
        finalDictionary.updateValue(preferrence, forKey: "otherInterest")
        finalDictionary.updateValue(swichStatus, forKey: "regularOccupation")
        
        print(finalDictionary)
       let finalDictForUpdate = PersonalData.init(json:finalDictionary)
        
        RealmWrapper.sharedInstance.addObjectInRealmDB(finalDictForUpdate)
        RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey(completation: {
            DatabaseManager.sharedInstance.currentInfo?.personalData = finalDictForUpdate
        })
        
          self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        toastAdd()
    }
   
    
    @IBAction func specialityChoose(_ sender: UIButton) {
        //openDatePicker()
        let tmpVC = self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "spetiality") as! SpetialityViewController
        tmpVC.otherSpetialityData = {stringArray , intArray in
            self.customSpetiality = stringArray
            self.indexesForSend = intArray
            print(self.customSpetiality,self.indexesForSend)
        }
        
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    
    func toastAdd() {
        // create a new style
        var style = ToastStyle()
        
        // this is just one of many style options
        style.messageColor = .white
        style.backgroundColor = .darkGray
        style.activityBackgroundColor = .black
        
        
        // present the toast with the new style
        self.view.makeToast("If you find an error, please report it immediately to the dean's office".localized(), duration: 5.0, position: .bottom,style: style)
        
        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style
        //  self.view.makeToast("This is a piece of toast") // now uses the shared style
        
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled  = true
        
        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled  = true
    }
    
    ////////////////////////////////////////////
    func openDatePicker() {
        let datePickerView = DatePickerView.init(dateMode: .data,
                                                 items: languages,
                                                 delegate: self,
                                                 dataSource: self)
        
        datePickerView.showInViewController(viewController: self)
    
        
    }
    
    //MARK: DataPickerViewDataSource
    
    func willDismissDataPickerView() {
        
        
    }
    
    func didSelectRow(row: Int) {

        self.choosenLabel.text = languages[row]
        
    }
    
    func willPresentDataPickerView(dataPicker: DatePickerView, selectedRow: Int) {
        self.view.endEditing(true)
    }
    
    func willDismissDataPickerViewWithDoneButton(selectedRow: Int) {
        
        
    }

    func populateProfesion() {
        let currantLang = Localize.currentLanguage()
        if currantLang == "ru" {
            if let profesions = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_ru {
                for profesion in profesions {
                self.languages.append(profesion)
                }
            }
        }else if currantLang == "hy" {
            if let profesions = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_hy {
                for profesion in profesions {
                    self.languages.append(profesion)
                }
            }
        }else{
            if let profesions = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_en {
                for profesion in profesions {
                    self.languages.append(profesion)
                }
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.preferrence = textField.text!
        textField.resignFirstResponder()
        
        return true
    }

}





