//
//  InfoTableViewController.swift
//  Menu
//
//  Created by AVROMIC on 2/23/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift

class InfoTableViewController: UITableViewController {
    
    @IBOutlet weak var infoTableView: InfoTableView!
    @IBOutlet weak var userAvatar: UIImageView!
    
    let userEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN
    let userRU = DatabaseManager.sharedInstance.currentInfo?.userModel_RU
    let userHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY
    
    let mother = "Mother".localized()
    
    override func viewDidLoad() {
        infoTableView.register(UINib.init(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        infoTableView.register(UINib.init(nibName: "ParentsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "parentInfoCell")
        infoTableView.register(UINib.init(nibName: "PersonalInfoTableViewFooterCell", bundle: nil), forCellReuseIdentifier: "personalFooter")
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.separatorStyle = .none
        infoTableView.estimatedRowHeight = 100
        infoTableView.translatesAutoresizingMaskIntoConstraints = true
        userAvatar.downloadedFrom(link: (userEN?.userPhoto)!)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.clickOnSubmite), name: NSNotification.Name("submite Button"), object: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch (indexPath.section) {
        case 0:
            let userCell = tableView.dequeueReusableCell(withIdentifier: "infoCell",for: indexPath) as! InfoTableViewCell
            let userEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN
            let userRU = DatabaseManager.sharedInstance.currentInfo?.userModel_RU
            let userHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY
            let currantLang = Localize.currentLanguage()
            switch currantLang {
            case "en":
                userCell.fillData(userData: userEN)
                break
            case "hy":
                userCell.fillData(userData: userHY)
                break
            case "ru":
                userCell.fillData(userData: userRU)
                break
            default:
                return userCell
                
           }
           cell = userCell
        case 1:
            let parentsCell = tableView.dequeueReusableCell(withIdentifier: "parentInfoCell", for: indexPath) as! ParentsInfoTableViewCell
            let fatherEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN?.father
            let fatherRU = DatabaseManager.sharedInstance.currentInfo?.userModel_RU?.father
            let fatherHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY?.father
            let currantLang = Localize.currentLanguage()
            switch currantLang {
            case "en":
                parentsCell.fillDataFather(userData: fatherEN)
            case "hy":
                parentsCell.fillDataFather(userData: fatherHY)
            case "ru":
                parentsCell.fillDataFather(userData: fatherRU)
            default:
                return parentsCell
            }
            cell = parentsCell
        case 2:
           let parentsCell1 = tableView.dequeueReusableCell(withIdentifier: "parentInfoCell", for: indexPath) as! ParentsInfoTableViewCell
            
            let motherEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN?.mather
            let motherRU = DatabaseManager.sharedInstance.currentInfo?.userModel_RU?.mather
            let motherHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY?.mather
            let currantLang = Localize.currentLanguage()
            switch currantLang {
            case "en":
                parentsCell1.fillDataMother(userData: motherEN)
            case "hy":
                parentsCell1.fillDataMother(userData: motherHY)
            case "ru":
                parentsCell1.fillDataMother(userData: motherRU)
            default:
                return parentsCell1
            }
            cell = parentsCell1
        default:
            print("default")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            let currantLang = Localize.currentLanguage()
            switch currantLang {
            case "en":
                return userEN?.fullName
            case "hy":
                return userHY?.fullName
            case "ru":
                return userRU?.fullName
            default:
                return userEN?.fullName
            }
        }
        else if section == 1 {
            return "Father".localized()
        }
        else {
            return "Mother".localized()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2{
        let footerCell = tableView.dequeueReusableCell(withIdentifier: "personalFooter") as! PersonalInfoTableViewFooterCell
            footerCell.submiteButtonOutlet.setTitle("Comfirm personal Data".localized(), for: .normal) 
        return footerCell
        }
    return nil
    }
    
    @objc func clickOnSubmite() {
        let tmpVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "submite")
        self.navigationController?.pushViewController(tmpVC!, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 40
        }
    return 0
    }
}
