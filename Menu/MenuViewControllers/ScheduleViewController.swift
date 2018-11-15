//
//  ScheduleViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Foundation
import Localize_Swift
import RealmSwift
import SConnection
import Toast_Swift

class ScheduleViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var scheduleModeData = DatabaseManager.sharedInstance.currentInfo?.sheduleList?.schedulesList
    var editDate = DatabaseManager.sharedInstance.currentInfo?.sheduleList?.editDate
    var refresher: UIRefreshControl!
    var token = UserDefaults.standard.string(forKey: "token")
    
    @IBOutlet weak var scheduleCollection: UICollectionView?
    @IBOutlet weak var dateLabel: UILabel?
    
    @IBOutlet weak var selectDateButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notification for localize
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        selectDateButton?.setTitle("Select date".localized(), for: .normal)
        refresher = UIRefreshControl()
        // tableview delegates
        scheduleCollection?.delegate = self
        scheduleCollection?.dataSource = self
        self.scheduleCollection?.register(UINib.init(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleCollectionCellID")
        self.scheduleCollection?.register(UINib.init(nibName: "NoDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
        scheduleCollection?.alwaysBounceVertical = true
        scheduleCollection?.clipsToBounds = true
        updateShceduleTableData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentDateScroller()
    }
    
    @IBAction func selectDateButtonClick(_ sender: UIButton) {
        let dateVC = getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "datePopUpVC") as? DatePopUpViewController
        dateVC?.onClickDateDone = { date in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            
            for item in self.scheduleModeData! {
                let sheduleDate = item.date/1000
                let sheduleDa = Date.init(timeIntervalSince1970: TimeInterval(sheduleDate))
                let sheduleDateFormatedDate = formatter.string(for: sheduleDa)
                print(sheduleDateFormatedDate!)
                if sheduleDateFormatedDate! == date {
                    print(item)
                    print(item.customId)
                    UserDefaults.standard.set(item.customId, forKey: "current Schedule pozition ID")
                    UserDefaults.standard.synchronize()
                    let currentIndexPath = IndexPath.init(item: item.customId  , section: 0)
                    self.scheduleCollection?.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
                    
                }
            }            
        }
        self.navigationController?.pushViewController(dateVC!, animated: true)
        
    }
    
    // MARK: UiCollectionViewDelegate, UiCollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if scheduleModeData != nil {
            return (scheduleModeData!.count)
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if scheduleModeData?.count != nil {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.scheduleColectionCell, for: indexPath) as? MyCollectionViewCell
        /////
        cell?.onClickSheduleTableDone = {lesson in
            let tmpVc = self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "details") as! ScheduleDetailsViewController
            let currantLang = Localize.currentLanguage()
            if currantLang == "ru" {
                tmpVc.subjectValueLabel?.text = lesson.subjectName_ru
                tmpVc.buildingValueLabel?.text = lesson.corpus_ru
                tmpVc.lectureValueLabel?.text = lesson.lecture_ru
            } else if currantLang == "hy" {
                tmpVc.subjectValueLabel?.text = lesson.subjectName_hy
                tmpVc.buildingValueLabel?.text = lesson.corpus_hy
                tmpVc.lectureValueLabel?.text = lesson.lecture_hy
            }else {
                tmpVc.subjectValueLabel?.text = lesson.subjectName_en
                tmpVc.buildingValueLabel?.text = lesson.corpus_en
                tmpVc.lectureValueLabel?.text = lesson.lecture_en
            }
            
            tmpVc.hourValueLabel?.text = lesson.hour
            tmpVc.roomValueLabel?.text = lesson.room
            tmpVc.noValueLabel?.text = lesson.number
         
            self.navigationController?.pushViewController(tmpVc, animated: true)
            tmpVc.okButtonLabel?.isEnabled = false
            tmpVc.okButtonLabel?.isHidden = true
//            self.parent?.addChildViewController(tmpVc)
//            tmpVc.view.frame = (self.parent?.view.frame)!
//            self.parent?.view.addSubview(tmpVc.view)
        }
        
        if scheduleModeData![indexPath.row].customId == indexPath.row  {
            var lessonArray = [Lesson]()
            for lesson in scheduleModeData![indexPath.row].lessonsList {
                lessonArray.append(lesson)
            }
            cell?.lessons = lessonArray
        }
            return cell!
        } else {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as? NoDataCollectionViewCell
         return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width:(scheduleCollection?.frame.size.width)! , height: (scheduleCollection?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.scheduleCollection?.reloadData()
    }
    
    func updateShceduleTableData() {
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(populateSchedule), for: UIControlEvents.valueChanged)
        scheduleCollection?.addSubview(refresher)
        
    }
    
    @objc func populateSchedule() {
         if(SConnection.isConnectedToNetwork()){
        UserRequestService.sharedInstance.updateScheduleDB(endpoint: "schedule.php", token: token!, editDate: editDate, succsesBlock: { (success,code) in
            let status = code
            if status == 200 {
                self.scheduleModeData = UserRequestService.sharedInstance.currentInfo?.sheduleList?.schedulesList
                self.scheduleCollection?.reloadData()
                self.refresher.endRefreshing()
            }else {
                self.refresher.endRefreshing()
                self.toastAdd(messageText: "You already have the latest data.".localized())
            }
            
        }) { (errorBlock,code)  in
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
    
    func currentDateScroller() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from:Date())
        
       // let datt =
        print(dateString)
        if scheduleModeData != nil {
        for item in self.scheduleModeData! {
            let sheduleDate = item.date/1000
            let sheduleDa = Date.init(timeIntervalSince1970: TimeInterval(sheduleDate))
            let sheduleDateFormatedDate = formatter.string(for: sheduleDa)
            print(sheduleDateFormatedDate!)
            print(dateString)
            if sheduleDateFormatedDate! == dateString {
                
                //print(item)
               // print(item.customId)
                let currentIndexPath = IndexPath.init(item: item.customId  , section: 0)
                UserDefaults.standard.set(item.customId, forKey: "current Schedule pozition ID")
                UserDefaults.standard.synchronize()

                self.scheduleCollection?.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
               // self.scheduleCollection?.reloadData()
                return
            }else {
                let itemID = UserDefaults.standard.integer(forKey: "current Schedule pozition ID")
                let currentIndexPath = IndexPath.init(item:  itemID , section: 0)
                self.scheduleCollection?.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
                //return
            }
        }
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
