//
//  AbsenceTableViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/5/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import RealmSwift

class AbsenceTableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var monthsCollection: UICollectionView!
    var absenceByMonth = [AbsenceByMonth]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthsCollection.delegate = self
        monthsCollection.dataSource = self
        self.monthsCollection.register(UINib.init(nibName: "InTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InTablecollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return absenceByMonth.count
       
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InTablecollectionCell", for: indexPath) as! InTableCollectionViewCell
        if (indexPath.row == absenceByMonth[indexPath.row].customID){
            cell.feelData(absenc: absenceByMonth[indexPath.row])
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width:(monthsCollection?.frame.size.height)! , height: (monthsCollection?.frame.size.height)!)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.scheduleColectionCell, for: indexPath) as? MyCollectionViewCell
//        if scheduleModeData![indexPath.row].customId == indexPath.row  {
//            var lessonArray = [Lesson]()
//            for lesson in scheduleModeData![indexPath.row].lessonsList {
//                lessonArray.append(lesson)
//            }
//            cell?.lessons = lessonArray
//        }
//
//        return cell!
//    }
}
