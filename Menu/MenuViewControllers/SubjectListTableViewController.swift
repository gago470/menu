//
//  SubjectListTableViewController.swift
//  Menu
//
//  Created by AVROMIC on 3/1/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import RealmSwift
import SConnection
import Toast_Swift

class SubjectListTableViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var subjectModelData = DatabaseManager.sharedInstance.currentInfo?.subjectList?.subjectLists
    var refresher: UIRefreshControl!
    var token = UserDefaults.standard.string(forKey: "token")
    var editDate = DatabaseManager.sharedInstance.currentInfo?.subjectList?.editData
    @IBOutlet weak var subjectCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Subject list"
        subjectCollection.delegate = self
        subjectCollection.dataSource = self
        self.subjectCollection.register(UINib.init(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "subjectCollectionID")
        subjectCollection?.alwaysBounceVertical = true
        subjectCollection?.clipsToBounds = true
        updateSubjectTableData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if subjectModelData != nil {
            return (subjectModelData!.count)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCollectionID", for: indexPath) as? SubjectCollectionViewCell
        
        cell?.onClickSubjectTableDone = {subject in
            let tmpVc = self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "subjectDetails") as! SubjectDetailsViewController
            
            let currantLang = Localize.currentLanguage()
            if currantLang == "ru" {
                
                tmpVc.subjectName?.text = subject.subjectName_ru
                tmpVc.professionValueLabel?.text = subject.detailsOfSubject?.profession_ru
                tmpVc.semesterValueLabel?.text = subject.detailsOfSubject?.semester_ru
                tmpVc.studyLanguageValueLabel?.text = subject.detailsOfSubject?.stadyLanguage_ru
                tmpVc.bySpecialityValueLabel?.text = subject.detailsOfSubject?.bySpeciality_ru
                tmpVc.subjectTypeValueLabel?.text = subject.detailsOfSubject?.subjectType_ru
                tmpVc.subjectTeachingTypeValueLabel?.text = subject.detailsOfSubject?.subjectTeachingType_ru
                tmpVc.examinationTypeValueLabel?.text = subject.detailsOfSubject?.exType_ru
            } else if currantLang == "hy" {
                tmpVc.subjectName?.text = subject.subjectName_hy
                tmpVc.professionValueLabel?.text = subject.detailsOfSubject?.profession_hy
                tmpVc.semesterValueLabel?.text = subject.detailsOfSubject?.semester_hy
                tmpVc.studyLanguageValueLabel?.text = subject.detailsOfSubject?.stadyLanguage_hy
                tmpVc.bySpecialityValueLabel?.text = subject.detailsOfSubject?.bySpeciality_hy
                tmpVc.subjectTypeValueLabel?.text = subject.detailsOfSubject?.subjectType_hy
                tmpVc.subjectTeachingTypeValueLabel?.text = subject.detailsOfSubject?.subjectTeachingType_hy
                tmpVc.examinationTypeValueLabel?.text = subject.detailsOfSubject?.exType_hy
            }else {
                tmpVc.subjectName?.text = subject.subjectName_en
                tmpVc.professionValueLabel?.text = subject.detailsOfSubject?.profession_en
                tmpVc.semesterValueLabel?.text = subject.detailsOfSubject?.semester_en
                tmpVc.studyLanguageValueLabel?.text = subject.detailsOfSubject?.stadyLanguage_en
                tmpVc.bySpecialityValueLabel?.text = subject.detailsOfSubject?.bySpeciality_en
                tmpVc.subjectTypeValueLabel?.text = subject.detailsOfSubject?.subjectType_en
                tmpVc.subjectTeachingTypeValueLabel?.text = subject.detailsOfSubject?.subjectTeachingType_en
                tmpVc.examinationTypeValueLabel?.text = subject.detailsOfSubject?.exType_en
            }
            
            tmpVc.hoursValueLabel?.text = subject.detailsOfSubject?.hours.description
            tmpVc.creditValueLabel?.text = subject.detailsOfSubject?.credit.description
           
            self.navigationController?.pushViewController(tmpVc, animated: true)

        }
        
        if subjectModelData![indexPath.row].customID == indexPath.row  {
            var subjectArray = [SubjectListOfSemester]()
            for subject in subjectModelData![indexPath.row].subjectListOfSemesters {
                subjectArray.append(subject)
            }
            cell?.subject = subjectArray
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width:(subjectCollection?.frame.size.width)! , height: (subjectCollection?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func updateSubjectTableData() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(populateGrade), for: UIControlEvents.valueChanged)
        subjectCollection?.addSubview(refresher)
    }
    
    @objc func populateGrade() {
         if(SConnection.isConnectedToNetwork()){
        UserRequestService.sharedInstance.updateSubjectDb(endpoint: "sub_list.php", token: token, editDate: editDate, succsesBlock: { (success,code) in
            let status = code
            if status == 200 {
                self.subjectModelData=DatabaseManager.sharedInstance.currentInfo?.subjectList?.subjectLists
                self.subjectCollection?.reloadData()
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
