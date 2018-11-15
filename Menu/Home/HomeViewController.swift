//
//  HomeViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import RealmSwift

class HomeViewController: ToolBarViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    var scheduleModeData = DatabaseManager.sharedInstance.currentInfo?.sheduleList?.schedulesList
    var absenceCount = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.absenceCount
    var avarageScore = DatabaseManager.sharedInstance.currentInfo?.gradeModel?.avarageGade
    var refresher: UIRefreshControl!
    var elDrawer: SXDrawerController?
    var token = UserDefaults.standard.string(forKey: "token")
    
    @IBOutlet weak var avarageScoreLabel: UILabel!
    @IBOutlet weak var absenceCountLabel: UILabel!
    @IBOutlet weak var averageScoreParrView: UIView!
    @IBOutlet weak var absenceParrView: UIView!
    @IBOutlet weak var absenceView: UIView!
    @IBOutlet weak var scorView: UIView!
    @IBOutlet weak var avarageScoreButtonText: UIButton!
    @IBOutlet weak var absenceButtonText: UIButton!
    @IBOutlet weak var scheduleButtonOutlet: UIButton!
    
    
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var absenceLabel: UILabel!
    @IBOutlet weak var collactionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         scheduleButtonOutlet.setTitle("Schedule".localized(), for: .normal)
        scheduleButtonOutlet.setTitleColor(UIColor.black, for: .normal)
        
        if let loggedIn = UserDefaults.standard.value(forKey: "loggedIn") as? Bool {
            if loggedIn {
                welcome()
                UserDefaults.standard.set(false, forKey: "loggedIn")
                UserDefaults.standard.synchronize()
            }
        }
        title = "Emeduni"
        //MARK: Collection view data source register
        collactionView?.delegate = self
        collactionView?.dataSource = self
        self.collactionView?.register(UINib.init(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleCollectionCellID")
        self.collactionView?.register(UINib.init(nibName: "NoDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
        collactionView?.alwaysBounceVertical = true
        collactionView?.clipsToBounds = true
        refresher = UIRefreshControl()
        
        let leftBarItem = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style: .done, target: self, action: #selector(openMenu))
        self.leftItems = [leftBarItem]
        
        // self.absenceParrView.layer.shadowOffset = CGSize(width: -5.0, height: -5.0)
        self.absenceParrView.layer.shadowOpacity = 0.3
        
        // self.absenceParrView.layer.shadowColor = UIColor.purple.cgColor
        self.averageScoreParrView.layer.shadowOpacity = 0.3
        
        // MARK: Absence view
        self.absenceView.layer.borderWidth = 2
        self.absenceView.layer.borderColor = UIColor.white.cgColor
        self.absenceView.layer.cornerRadius = absenceView.frame.width/2
        
        // MARK: Score view
        self.scorView.layer.borderWidth = 2
        self.scorView.layer.borderColor = UIColor.white.cgColor
        self.scorView.layer.cornerRadius = absenceView.frame.width/2
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        updateShceduleTableData()
    }
    
    // func for adding avarage score and absence views in home view
    override func viewDidLayoutSubviews() {
        averageScoreLabel.text = "Average score".localized()
        absenceLabel.text = "Absence".localized()
        self.collactionView.reloadData()
        avarageScoreLabel.text = avarageScore?.description
        absenceCountLabel.text = absenceCount?.description
    }
    override func awakeFromNib() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        avarageScoreLabel.text = avarageScore?.description
        absenceCountLabel.text = absenceCount?.description
        
    }
    
    @IBAction func scheduleButton(_ sender: UIButton) {
        let tmpStoryB = UIStoryboard(name: "Main", bundle: nil)
        let tmpVC = tmpStoryB.instantiateViewController(withIdentifier: "Schedule")
        self.navigationController?.pushViewController(tmpVC, animated: true) 
    }
    
    // bottun to moveing from home view to absence view
    @IBAction func absenceButton(_ sender: Any) {
        let tmpStoryB = UIStoryboard(name: "Main", bundle: nil)
        let tmpVC = tmpStoryB.instantiateViewController(withIdentifier: "Absence")
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    // bottun to moveing from hime view to progress view
    @IBAction func avarageScoreButton(_ sender: Any) {
        let tmpStoryB = UIStoryboard(name: "Main", bundle: nil)
        let tmpVC = tmpStoryB.instantiateViewController(withIdentifier: "Progress")
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    // navigatinon bar controller when view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let navBackgroundImage:UIImage! = UIImage(named: "navigationHeaderBG")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,for: .default)
        self.toolBar?.isTranslucent = false
        self.toolBar?.setBackgroundImage(UIImage(named: "toolbarBG"), forToolbarPosition: .bottom, barMetrics: .default)
     //   currentDateScroller()
        avarageScoreLabel.text = avarageScore?.description
        absenceCountLabel.text = absenceCount?.description
        
        
        
        // elf.toolBar?.barTintColor = UIColor.init(red: 49/255, green: 76/255, blue: 103/255, alpha: 1.0)
    }
    
    // navigation bar controller when view will dis appear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: Open Menu
    @objc func openMenu() {
        print("menu clicked")
        self.elDrawer?.open()
    }
    
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    // MARK: UiCollectionViewDelegate, UiCollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if /*scheduleModeData!.count != 0 && scheduleModeData?.count != 0 ||*/ scheduleModeData != nil {
            print(scheduleModeData!.count)
            return (scheduleModeData!.count)
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if scheduleModeData?.count != nil {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.scheduleColectionCell, for: indexPath) as? MyCollectionViewCell
        
        //stex kkanchenk ed clusrern u ira mej kgrenk ed show i masern
        
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
            self.addChildViewController(tmpVc)
            tmpVc.view.frame = self.view.frame
            self.view.addSubview(tmpVc.view)            
        }
        
        if scheduleModeData![indexPath.row].customId == indexPath.row  {
            var lessonArray = [Lesson]()
            for lesson in scheduleModeData![indexPath.row].lessonsList {
                lessonArray.append(lesson)
            }
            cell?.lessons = lessonArray
        }
        return cell!
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as? NoDataCollectionViewCell
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width:(collactionView?.frame.size.width)! , height: (collactionView?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func updateShceduleTableData() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(populateSchedule), for: UIControlEvents.valueChanged)
        collactionView?.addSubview(refresher)
        //(self, action: #selector(MyCollectionViewCell.populateSchedule), for: UIControlEvents.valueChanged)
    }
    
    @objc func populateSchedule() {
        UserRequestService.sharedInstance.updateScheduleDB(endpoint: nil, token: token!, editDate: nil, succsesBlock: { (success,code) in
            self.scheduleModeData = UserRequestService.sharedInstance.currentInfo?.sheduleList?.schedulesList
            self.collactionView?.reloadData()
            self.refresher.endRefreshing()
        }) { (errorBlock,code) in
            self.collactionView?.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    func currentDateScroller() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from:Date())
        
        // let datt =
        print(dateString)
        
        for item in self.scheduleModeData! {
            let sheduleDate = item.date/1000
            let sheduleDa = Date.init(timeIntervalSince1970: TimeInterval(sheduleDate))
            let sheduleDateFormatedDate = formatter.string(for: sheduleDa)
            print(sheduleDateFormatedDate!)
            if sheduleDateFormatedDate! == dateString {
                //print(item)
                // print(item.customId)
                let currentIndexPath = IndexPath.init(item: item.customId  , section: 0)
                UserDefaults.standard.set(item.customId, forKey: "current Schedule pozition ID")
                UserDefaults.standard.synchronize()
                
                self.collactionView?.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
                // self.scheduleCollection?.reloadData()
                
            }else {
                let itemID = UserDefaults.standard.integer(forKey: "current Schedule pozition ID")
                let currentIndexPath = IndexPath.init(item:  itemID , section: 0)
                self.collactionView?.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    @objc func welcome() {
        let tmpVc = self.getViewControllerWithStoryBoard(sbName: "Main", vcIndentifier: "welcome") as! WelcomeViewController
        self.addChildViewController(tmpVc)
        tmpVc.view.frame = self.view.frame
        self.view.addSubview(tmpVc.view)
    }
}

