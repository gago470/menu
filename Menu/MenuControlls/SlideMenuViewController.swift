//
//  SlideMenuViewController.swift
//  SixelConsultig
//
//  Created by My Mac on 10/30/17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import UIKit
import MobileCoreServices
import Localize_Swift
import Alamofire


class SlideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    @IBOutlet weak var userINMenuInfo: UILabel!
    @IBOutlet weak var userINmenuImage: UIImageView!
    var notif = ""
    var prog = ""
    var absenc = ""
    var sched = ""
    var finance = ""
    var settings = ""
    var sbjList = ""
    
    var userInfoEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN
    var userInfoHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY
    var userInfoRu = DatabaseManager.sharedInstance.currentInfo?.userModel_RU
    
    var menuItemsArr =  [/*"Message",*/"Notification","Progress","Absence","Schedule","Finance","Settings","Subjects"]
    
    var navigation:UINavigationController?
    
    private var estimatedHeight: CGFloat {
        var estimatedHeight_: CGFloat = 70.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            estimatedHeight_ = 70.0
        }
        return estimatedHeight_
    }
    
    fileprivate var openCourses = [Int]()
    
    @IBOutlet weak var settingsMenuTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        self.userINmenuImage.downloadedFrom(link: (userInfoEN?.userPhoto)!)
        //        var imageData: Data = UIImagePNGRepresentation(image)
        //        var imageUIImage: UIImage = UIImage(data: imageData)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        self.settingsMenuTableView?.delegate = self
        self.settingsMenuTableView?.dataSource = self
        self.settingsMenuTableView?.rowHeight = 70.0 //UITableViewAutomaticDimension
        self.settingsMenuTableView?.estimatedRowHeight = self.estimatedHeight
        self.settingsMenuTableView?.register(UINib(nibName: "SXMenuCell", bundle: nil), forCellReuseIdentifier: "menuCell")
    }
    
    override func viewDidLayoutSubviews() {
        notif = "Notification".localized().capitalized
        prog = "Progress".localized().capitalized
        absenc = "Absence".localized().capitalized
        sched = "Schedule".localized().capitalized
        finance = "Finance".localized().capitalized
        settings = "Settings".localized().capitalized
        sbjList = "Subjects".localized().capitalized
        menuItemsArr = [notif.capitalized,prog.capitalized,sbjList,sched.capitalized,absenc.capitalized,finance.capitalized,settings.capitalized]
        userInfoData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a = [#imageLiteral(resourceName: "Notification"),#imageLiteral(resourceName: "Progress"),#imageLiteral(resourceName: "Subject_list"),#imageLiteral(resourceName: "Schedule"),#imageLiteral(resourceName: "Absence"),#imageLiteral(resourceName: "Finance"),#imageLiteral(resourceName: "Settings")]
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? SXMenuCell
        cell?.menuTitle?.text = menuItemsArr[indexPath.row]
        cell?.menuIcon?.image = a[indexPath.row]
        return cell!
    }
    
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.settingsMenuTableView?.reloadData()
//        self.reloadView()
        self.userINMenuInfo.reloadInputViews()
    
    }
    
    @IBAction func persInfoButton(_ sender: Any) {
        if let vc =  self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "PersonalInfo" ) {
            if let parentVC = parent as? SXDrawerController {
                parentVC.open()
                if let main = parentVC.mainViewController as? UINavigationController{
                    main.pushViewController(vc, animated: true)
                }
            }
        }
    }
}


extension SlideMenuViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vcArrays = [String]()
        
        switch menuItemsArr[indexPath.row] {
        case "Уведомления"  :
            vcArrays.append("Notification")
            print("Notification")
        case "Предметы" :
            vcArrays.append("Subjects")
        case "Успеваемость" :
            vcArrays.append("Progress")
            print("Progress")
        case "Посещаемость" :
            vcArrays.append("Absence")
            print("Absence")
        case "Расписание" :
            vcArrays.append("Schedule")
            print("Schedule")
        case "Финансы" :
            vcArrays.append("Finance")
            print("Finance")
        case "Настройки" :
            vcArrays.append("Settings")
            print("Settings")
        case "Notification" :
            vcArrays.append("Notification")
        case "Subjects" :
            vcArrays.append("Subjects")
        case "Progress" :
            vcArrays.append("Progress")
        case "Absence" :
            vcArrays.append("Absence")
        case "Schedule" :
            vcArrays.append("Schedule")
        case "Finance" :
            vcArrays.append("Finance")
        case "Settings" :
            vcArrays.append("Settings")
        case "Ծանուցում" :
            vcArrays.append("Notification")
        case "Առարկայացանք" :
            vcArrays.append("Subjects")
        case "Առաջադիմություն" :
            vcArrays.append("Progress")
        case "Բացակայություն" :
            vcArrays.append("Absence")
        case "Դասացուցակ" :
            vcArrays.append("Schedule")
        case "Կարգավորումներ" :
            vcArrays.append("Settings")
        case "Ֆինանս" :
            vcArrays.append("Finance")
        default:
            break
        }
        
        if let vc =  self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: vcArrays[0] ) {
            if let parentVC = parent as? SXDrawerController {
                parentVC.open()
                if let main = parentVC.mainViewController as? UINavigationController{
                    main.pushViewController(vc, animated: true)
                    print(menuItemsArr.count)
                }
            }
        }
    }
    func userInfoData(){
        let currentLang = Localize.currentLanguage()
        var index = ""
        
        if currentLang == "hy"{
            switch userInfoHY?.course {
            case 1:
                index = "-ին կուրս"
            case 2:
                index = "-րդ կուրս"
            default:
                index = "-րդ կուրս"
            }
            self.userINMenuInfo.text = (userInfoHY?.fullName)! + "\n" + (userInfoHY?.course.description)! + index
        }else if currentLang == "ru" {
            switch userInfoRu?.course {
            case 1:
                index = "-й курс"
            case 2:
                index = "-ой курс"
            default:
                index = "-й курс"
            }
            self.userINMenuInfo.text = (userInfoRu?.fullName)! + "\n" + (userInfoRu?.course.description)! + index
        }else {
            switch userInfoEN?.course {
            case 1:
                index = "-st course"
            case 2:
                index = "-nd course"
            default:
                index = "-th course"
            }
            self.userINMenuInfo.text = ( (userInfoEN?.fullName)! + "\n" + (userInfoEN?.course.description)! + index )
            
        }
    }
}

