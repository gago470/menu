//
//  SettingsViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import SConnection
import Toast_Swift

class SettingsViewController: UIViewController {
    
    // vareabels for About pop up
    var aboutTitle = ""
    var message = ""
    var token = UserDefaults.standard.string(forKey: "token")
    @IBOutlet weak var logOutFromAllLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
   // @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var logOutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //  notification for localize
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    @IBAction func languageButton(_ sender: UIButton) {
        let tmpVC =  self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "LanguagesViewController") as! LanguagesViewController
         self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    // localizations labels
    override func viewDidLayoutSubviews() {
        message = "Emeduni for IOS Version 1.0 (build 1) Avromic LLC".localized().capitalized
        aboutTitle = "About".localized().capitalized
        aboutLabel.text = "About".localized()
        languageLabel.text = "Language".localized()
       // notificationLabel.text = "Notification".localized()
        logOutLabel.text = "Log out".localized()
        logOutFromAllLabel.text = "Log out from all devices".localized()
    }
    
    //    pop up alert for about
    @IBAction func aboutButtonAction(_ sender: Any) {
        let aboutAllertCont = UIAlertController(title: aboutTitle, message: message, preferredStyle: .alert)
        let image = UIImage(named: "aboutImageNew")
        aboutAllertCont.addImage(image: image!)
        aboutAllertCont.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(aboutAllertCont, animated: true, completion: nil)
    }
    
    //    func for loging out from app
    @IBAction func logOutButton(_ sender: Any) {
        let logOutAlert = UIAlertController(title: "Do you want to logout?".localized(), message: "", preferredStyle: .alert)
        logOutAlert.addAction(UIAlertAction(title: "Yes".localized(), style: .default, handler: { (nil) in
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let tmpVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginVC")
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = tmpVC
            UserDefaults.standard.set("", forKey: "token")
            RealmWrapper.sharedInstance.deleteObjectsOfModelInRealmDB(Info.self)
            RealmWrapper.sharedInstance.deleteObjectsOfModelInRealmDB(Token.self)
            UserDefaults.standard.removeObject(forKey: "loggedIn")
        }))
        logOutAlert.addAction(UIAlertAction(title: "No".localized(), style: .default, handler: nil))
        self.present(logOutAlert, animated: true, completion: nil)
    }
    
    // reloading pages for localization
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func logOutFromAll(_ sender: UIButton) {
        UserRequestService.sharedInstance.logOut(endpoint: "/logout_all", token: token, editDate: nil, succsesBlock: { (success,code) in
            let status = code
            if status == 200 {
                LogOut.sharedInstance.logOut()
            }else {
               print(success)
            }
        }) { (success,code) in
            let status = code
        
            
            LogOut.sharedInstance.logOut()
            //print(success)
        }
    }
}

// extension for adding image in alertController
extension UIAlertController {
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 245, height: 300)
        let imgSize = image.size
        
        var ratio : CGFloat!
        if (imgSize.width > imgSize.height) {
            ratio = maxSize.width / imgSize.width
        } else {
            ratio = maxSize.height  / imgSize.height
        }
        
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        
        var resizedImage = image.imageWithSize(scaledSize)
        
        let left = (maxSize.width - resizedImage.size.width) / 2
        resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsetsMake(0, -left, 0, 0))
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
}

