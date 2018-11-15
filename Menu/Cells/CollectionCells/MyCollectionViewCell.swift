//
//  MyCollectionViewCell.swift
//  CollectionTableMix
//
//  Created by My Mac on 12/25/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Foundation
import Localize_Swift
import RealmSwift

class MyCollectionViewCell:  UICollectionViewCell,UITableViewDataSource,UITableViewDelegate {
    
    var scheduleModeData = DatabaseManager.sharedInstance.currentInfo?.sheduleList?.schedulesList
    
    var lessons: [Lesson]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var onClickSheduleTableDone: (( _ lesson : Lesson)->())?
    
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView?
    // tableViewi celleri qanakn e vorn kpoxacnem view controlleri mejic
    var cellCount = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView?.register(UINib.init(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCellID")
        tableView?.register(UINib.init(nibName: "ScheduleTableHeder", bundle: nil), forCellReuseIdentifier: "scheduleTableHeader")
        tableView?.delegate = self
        tableView?.dataSource = self

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCellID", for: indexPath) as? ScheduleTableViewCell
        if indexPath.row  == lessons![indexPath.row].customId {
            cell?.contentView.layer.borderWidth = 0.5
            cell?.contentView.layer.borderColor = UIColor.black.cgColor
            cell?.fiilDataOFEachCell(lesson: lessons![indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0)
        {
            
            cell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 1)
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "scheduleTableHeader") as! ScheduleTableHeder
        headerCell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 0.5)
        
        let date = NSDate(timeIntervalSince1970: (TimeInterval(lessons![0].customDate)/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMMM. yyyy"
        dateFormatter.locale = Locale(identifier: Localize.currentLanguage())
        let dateString = dateFormatter.string(from: date as Date)
        headerCell.dayLabel?.text = dateString
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if  onClickSheduleTableDone != nil {
            onClickSheduleTableDone!(lessons![indexPath.row])
        }
    }
}

