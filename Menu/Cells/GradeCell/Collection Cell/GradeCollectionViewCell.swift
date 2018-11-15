//
//  GradeCollectionViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/1/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import RealmSwift
import Localize_Swift

class GradeCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate {

    var gradeModelData = DatabaseManager.sharedInstance.currentInfo?.gradeModel?.gradebySemesters
    
    var grAde: [GradeOfSemester]? {
        didSet {
            self.gradeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var gradeTableView: UITableView!
    
    var onClickGradeTableDone: (( _ grade : GradeOfSemester)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradeTableView.register(UINib.init(nibName: "GradeTableViewCell", bundle: nil), forCellReuseIdentifier: "gradeTableCell")
        gradeTableView.register(UINib.init(nibName: "GradeTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: "gradeTableHeader")
        gradeTableView.delegate = self
        gradeTableView.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grAde!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0)
        {
            
            cell.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 158/255)
            
        }else {
            cell.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 191/255)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeTableCell", for: indexPath) as? GradeTableViewCell
        if indexPath.row  == grAde![indexPath.row].customId {
            cell?.contentView.layer.borderWidth = 0.5
            cell?.contentView.layer.borderColor = UIColor.black.cgColor
            cell?.feelGradeDataa(grade: grAde![indexPath.row])
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "gradeTableHeader") as! GradeTableViewHeaderCell
        headerCell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 0.5)
        headerCell.gradecountLabel.text = "\(grAde![0].customAvaraGrade)"
        if (grAde![0].customAvaraGrade > 0 && grAde![0].customAvaraGrade < 50) {
            headerCell.gradecountLabel.backgroundColor = UIColor.red
        }else if (grAde![0].customAvaraGrade > 50 && grAde![0].customAvaraGrade < 70) {
            headerCell.gradecountLabel.backgroundColor = UIColor.lightGray
        }else{
            headerCell.gradecountLabel.backgroundColor = UIColor.green
        }
        headerCell.semesterLabel.text = "Semester".localized() + " \(grAde![0].customSemNumber)"
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  onClickGradeTableDone != nil {
            onClickGradeTableDone!(grAde![indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
   
}
