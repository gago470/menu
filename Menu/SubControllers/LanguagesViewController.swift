//
//  LanguagesViewController.swift
//  Menu
//
//  Created by AVROMIC on 1/17/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class LanguagesViewController: UIViewController {
    
    //    strings for questinos to change languages
    var langChangeQuestionEN = "Do you want to change language?"
    var langChangeQuestionRU = "Вы хотите изменить язык?"
    var langChangeQuestionHY = "Ցանկանո՞ւմ եք փոխել լեզուն"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    button for change app language to armenian
    @IBAction func armenianLangChanger(_ sender: Any) {
        self.showAlert(lengChangeQuestion: self.langChangeQuestionHY, yesTitle: "Այո", noTitle: "Ոչ", languageCode: "hy")
    }
    
    //    button for change app language to russian
    @IBAction func russianLangChanger(_ sender: UIButton) {
        showAlert(lengChangeQuestion: langChangeQuestionRU, yesTitle: "Да", noTitle: "Нет", languageCode: "ru")
    }
    
    //    button for change app language to english
    @IBAction func englishLangChanger(_ sender: Any) {
        showAlert(lengChangeQuestion: langChangeQuestionEN, yesTitle: "Yes", noTitle: "No", languageCode: "en")
    }
    
    //    func for show alert for language change
    func showAlert(lengChangeQuestion: String, yesTitle: String, noTitle: String, languageCode: String) {
        let changeLanguageAlert = UIAlertController(title: lengChangeQuestion, message: "", preferredStyle: .actionSheet)
        changeLanguageAlert.addAction(UIAlertAction(title: yesTitle, style: .default, handler: { (nil) in
            Localize.setCurrentLanguage(languageCode)
            changeLanguageAlert.removeFromParentViewController()
            
        }))
        changeLanguageAlert.addAction(UIAlertAction(title: noTitle, style: .default, handler: { (nil) in
            changeLanguageAlert.removeFromParentViewController()
            
        }))
        self.present(changeLanguageAlert, animated: true, completion: nil)
    }
}
