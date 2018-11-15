//
//  SpetialityViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 7/11/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift

struct ExpandableNames {
    
    var isExpanded: Bool
    var names: [String]
    
}



class SpetialityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var okButtonoutlett: UIButton!

    var tableViewData = [ExpandableNames]()
    
    
    
    var otherSpetialityData: ((_ dataString: [String],[Int])->())?
    var statusArray = [Bool]()
//    var outArrayEn = Set<String>()
//    var outArrayRu = Set<String>()
//    var outArrayHy = Set<String>()
    var profession = [String]()
    var otherCustomSpetiality = [String]()
    var professionEn = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_en
    var professionRu = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_ru
    var professionHy = DatabaseManager.sharedInstance.currentInfo?.medicalProfessions_hy
    var selectedIndexisInDb = DatabaseManager.sharedInstance.currentInfo?.personalData?.spetialitys
    var otherSpetialitys = DatabaseManager.sharedInstance.currentInfo?.personalData?.otherSpetialitys
    var selectedIndexis = [Int]()
    var curentLanguage = Localize.currentLanguage()
    
   // var bla = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        populateSpetiality()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true)
        tableView.register(UINib.init(nibName: "SpetialityCell", bundle: nil), forCellReuseIdentifier: "spetialityCell")
        tableView.register(UINib.init(nibName: "SpetialityTableViewFooter", bundle: nil), forCellReuseIdentifier: "spetialityFooter")
        tableView.register(UINib.init(nibName: "CustomSpetialityCell", bundle: nil), forCellReuseIdentifier: "customSpetiality")
        tableView.register(UINib.init(nibName: "SpetialityHeaderCell", bundle: nil), forCellReuseIdentifier: "spetialityHeadr")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        okButtonoutlett.setTitle("Ok".localized(), for: .normal)
        tableViewData = [ExpandableNames(isExpanded: true, names: profession),
                         ExpandableNames(isExpanded: false, names: otherCustomSpetiality)
        ]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let button = RightAlignedIconButton(type: .system)
        if section == 0 {
            button.setTitle("Medical spetiality".localized(), for: .normal)
            button.setTitleColor(.black, for: .normal)
        } else {
            button.setTitle("Other".localized(), for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        button.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        if tableViewData[section].isExpanded {
        button.setImage(#imageLiteral(resourceName: "up1"), for: .normal)
        }else {
            button.setImage(#imageLiteral(resourceName: "down1"), for: .normal)
            
        }
       
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in tableViewData[section].names.indices {
            //print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = tableViewData[section].isExpanded
        tableViewData[section].isExpanded = !isExpanded
        button.setImage(isExpanded ? #imageLiteral(resourceName: "down1") : #imageLiteral(resourceName: "up1"), for: .normal)
        if isExpanded {
            
            tableView.deleteRows(at: indexPaths, with: .fade)
            print (statusArray)
        } else {
            
            tableView.insertRows(at: indexPaths, with: .fade)
           
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var hight = CGFloat()
        if section == 0 {
            hight = 0
        }else {
            hight = self.view.layer.frame.height/16
        }
        return hight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let button = UIButton(type: .contactAdd)
        if section == 0 {
            button.isEnabled = true
        }
        button.setTitle("Add spetiality".localized(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
       // button.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(addSpetiality), for: .touchUpInside)
        return button
    }
    
    @objc func addSpetiality(button : UIButton) {
        let tmpVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "otherSpetiality") as? OtherSpetialityViewController
        tmpVC?.otherSpetiality = { spetialty in
            self.otherCustomSpetiality.append(spetialty)
            self.tableViewData[1].names.append(spetialty) // spetialty
            self.tableView.reloadInputViews()
            self.tableView.reloadData()
           // print(self.bla , self.selectedIndexis)
        }
        self.addChildViewController(tmpVC!)
        self.view.addSubview((tmpVC?.view)!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.layer.frame.height/15
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return self.view.layer.frame.height/15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let checkableCell = tableView.dequeueReusableCell(withIdentifier: "spetialityCell")  as? SpetialityCell
            
            
                if statusArray[indexPath.row] {
                    checkableCell?.button.isSelected = true
                    //checkableCell?.button.setImage(#imageLiteral(resourceName: "check"), for:.normal)
                }else {
                     checkableCell?.button.isSelected = false
                }
            if (checkableCell?.button.isSelected)! {
                checkableCell?.button.setImage(#imageLiteral(resourceName: "check"), for:.normal)
            } else {
                checkableCell?.button.setImage(#imageLiteral(resourceName: "uncheck"), for:.normal)
            }
            
            checkableCell?.label.text = tableViewData[indexPath.section].names[indexPath.row]
            
            checkableCell?.onButtonSelected = {
                self.statusArray[indexPath.row] = true
                
            }
            checkableCell?.onButtonDeselect = {
                self.statusArray[indexPath.row] = false
                
            }
            checkableCell?.selectionStyle = .none;
            return checkableCell!
        }else {
            let customSpetialityCell = tableView.dequeueReusableCell(withIdentifier: "customSpetiality")  as? CustomSpetialityCell
            customSpetialityCell?.customSpetialityLabel.text = tableViewData[indexPath.section].names[indexPath.row] //otherSpetialitys?[indexPath.row]
            return customSpetialityCell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !tableViewData[section].isExpanded {
            return 0
        }
        
        return tableViewData[section].names.count
    }
    
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return  indexPath.section == 1
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
           if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.otherCustomSpetiality.remove(at: indexPath.row)
            self.tableViewData[1].names.remove(at: indexPath.row)
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
           }
        
    }
    
    @IBAction func okButton(_ sender: UIButton) {
       
        for item in statusArray.indices {
            if statusArray[item] {
                self.selectedIndexis.append(item + 1)
            }
        }
        if otherSpetialityData != nil {
            otherSpetialityData!( self.otherCustomSpetiality ,self.selectedIndexis)
        }                
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    @IBAction func otherButtonAction(_ sender: UIButton) {
//
//        let tmpVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "otherSpetiality") as? OtherSpetialityViewController
//        tmpVC?.otherSpetiality = { spetialty,array in
//            self.otherCustomSpetiality.append(spetialty)
//            self.tableViewData[1].names.append(spetialty) // spetialty
//
//            self.tableView.reloadInputViews()
//            self.tableView.reloadData()
//           // print(self.bla , self.selectedIndexis)
//        }
//        self.addChildViewController(tmpVC!)
//        self.view.addSubview((tmpVC?.view)!)
//    }
    
    func populateSpetiality() {
        if otherSpetialitys != nil {
            for item in otherSpetialitys! {
                otherCustomSpetiality.append(item)
            }
        }
        if curentLanguage == "ru" {
            if professionRu != nil {
                for item in professionRu! {
                    profession.append(item)
                }
                statusArray = Array(repeating: false, count: (professionRu?.count)!)
            }
        }else if curentLanguage == "hy" {
            if professionHy != nil {
                for item in professionHy! {
                    profession.append(item)
                }
                statusArray = Array(repeating: false, count: (professionHy?.count)!)
            }
        }else {
            if professionEn != nil {
                for item in professionEn! {
                    profession.append(item)
                }
                statusArray = Array(repeating: false, count: (professionEn?.count)!)
            }
        }
        for i in statusArray.indices {
            if selectedIndexisInDb != nil {
              for item in selectedIndexisInDb! {
                 if i == item {
                    statusArray[i - 1] = true
                }
              }
            }
        }
    }
}


class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth )
    }
}


