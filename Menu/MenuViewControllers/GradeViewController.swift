//
//  SecondViewController.swift
//  Menu
//
//  Created by My Mac on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift
import SConnection
import Toast_Swift

class GradeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var gradeModuleData = DatabaseManager.sharedInstance.currentInfo?.gradeModel?.gradebySemesters
    var refresher: UIRefreshControl!
    var token = UserDefaults.standard.string(forKey: "token")
    var editDate = DatabaseManager.sharedInstance.currentInfo?.gradeModel?.editDate
    
    
    @IBOutlet weak var gradeColectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradeColectionView.delegate = self
        gradeColectionView.dataSource = self
        gradeColectionView?.alwaysBounceVertical = true
        gradeColectionView?.clipsToBounds = true
        self.gradeColectionView?.register(UINib.init(nibName: "GradeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gradeCollectionCellID")
        updateGradeTableData()
        self.navigationController?.navigationBar.accessibilityLabel = "Grade"
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if gradeModuleData != nil {
            return (gradeModuleData!.count)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gradeCollectionCellID", for: indexPath) as? GradeCollectionViewCell
        
        cell?.onClickGradeTableDone = {grade in
             let tmpVc = self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "gradeDetails") as! GradeDetailsViewController
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            let datte = grade.detailOfGrade?.givingDate
            let givenDate = datte!/1000
            let date = Date.init(timeIntervalSince1970: TimeInterval(givenDate))
            let givenDateFormatedDate = formatter.string(for: date)
            
            let curentLanguage = Localize.currentLanguage()
            if curentLanguage == "ru" {
                tmpVc.subjectValueText = grade.subjectName_ru
            } else if curentLanguage == "hy" {
                tmpVc.subjectValueText = grade.subjectName_hy
            } else {
                tmpVc.subjectValueText = grade.subjectName_en
            }
            
            tmpVc.atemptValueText = grade.detailOfGrade?.times.description
            tmpVc.exameDateText = givenDateFormatedDate
           
            self.addChildViewController(tmpVc)
            self.navigationItem.hidesBackButton = true
            self.view.addSubview((tmpVc.view)!)
            
        }
        
        if gradeModuleData![indexPath.row].customID == indexPath.row  {
            var gradeArray = [GradeOfSemester]()
            for lesson in gradeModuleData![indexPath.row].gradeOfSemesters {
                gradeArray.append(lesson)
            }
            cell?.grAde = gradeArray
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width:(gradeColectionView?.frame.size.width)! , height: (gradeColectionView?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func updateGradeTableData() {
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(populateGrade), for: UIControlEvents.valueChanged)
        gradeColectionView?.addSubview(refresher)
    }

    @objc func populateGrade() {
        if(SConnection.isConnectedToNetwork()){
        UserRequestService.sharedInstance.updateGradeDb(endpoint: "grade.php", token: token, editDate: nil, succsesBlock: { (success,code) in
            let status = code
            if status == 200{
                self.gradeModuleData = DatabaseManager.sharedInstance.currentInfo?.gradeModel?.gradebySemesters
                self.gradeColectionView?.reloadData()
                self.refresher.endRefreshing()
            }else {
                self.refresher.endRefreshing()
                self.toastAdd(messageText: "You already have the latest data.".localized())
            }
            
        }) { (errorBlock,code) in
            let status = code
            if status == 401 {
                LogOut.sharedInstance.logOut()
            }else {
                self.refresher.endRefreshing()
            }
            self.refresher.endRefreshing()
        }    
    }else {
    self.refresher.endRefreshing()
    toastAdd(messageText: "No connection".localized())
    
  
    }
 }
    func toastAdd(messageText message : String) {
        // create a new style
        var style = ToastStyle()
        
        // this is just one of many style options
        style.messageColor = .white
        style.backgroundColor = .darkGray
        style.activityBackgroundColor = .black
        
        
        // present the toast with the new style
        self.view.makeToast(message, duration: 5.0, position: .bottom,style: style)
        
        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style
        //  self.view.makeToast("This is a piece of toast") // now uses the shared style
        
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled  = true
        
        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled  = true
    }

}
