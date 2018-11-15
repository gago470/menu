//
//  AbsenceListViewController.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/5/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import RealmSwift
import SConnection
import Toast_Swift

class AbsenceListViewController: UIViewController ,  UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var absenceCollection: UICollectionView!
    var absencebySemester = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.absenceBySemesters
    var editdate = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.editData
    var refresher: UIRefreshControl!
    var token = UserDefaults.standard.string(forKey: "token")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        absenceCollection.delegate = self
        absenceCollection.dataSource = self
        absenceCollection?.alwaysBounceVertical = true
        absenceCollection?.clipsToBounds = true
        absenceCollection.register(UINib.init(nibName: "NoDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
        absenceCollection.register(UINib.init(nibName: "AbsenceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "absenceCollectionViewCellID")
        updateAbsenceTableData()
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if absencebySemester != nil{
            return (absencebySemester?.count)!
        }else {
            return 1
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if absencebySemester != nil{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "absenceCollectionViewCellID", for: indexPath) as! AbsenceCollectionViewCell
        if absencebySemester![indexPath.row].customID == indexPath.row {
            var absenceArray = [AbsenceOfSemester]()
            for absenceOfSemester in absencebySemester![indexPath.row].absenceOfSemester {
                absenceArray.append(absenceOfSemester)
                
            }
            cell.absenceOfSemester = absenceArray
        }
        return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as? NoDataCollectionViewCell
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width:(absenceCollection?.frame.size.width)! , height: (absenceCollection?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func updateAbsenceTableData() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(populateSchedule), for: UIControlEvents.valueChanged)
        absenceCollection?.addSubview(refresher)
    }
    
    @objc func populateSchedule() {
        if(SConnection.isConnectedToNetwork()){
        UserRequestService.sharedInstance.updateAbsenceDb(endpoint: "absence.php", token: token, editDate: editdate, succsesBlock: { (success,code) in
            let status = code
            if status == 200 {
                self.absencebySemester = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.absenceBySemesters
                self.absenceCollection?.reloadData()
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
