//
//  AbsenceCollectionViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/5/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class AbsenceCollectionViewCell: UICollectionViewCell , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var absenceTable: UITableView!
    
    
    var absenceOfSemester: [AbsenceOfSemester]? {
        didSet {
            self.absenceTable.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        absenceTable.delegate = self
        absenceTable.dataSource = self
        absenceTable.register(UINib.init(nibName: "AbsenceTableViewCell", bundle: nil), forCellReuseIdentifier: "absenceTableViewCellID")
        absenceTable.register(UINib.init(nibName: "AbsenceTableViewHeaderCell", bundle: nil), forCellReuseIdentifier: "absenceTableViewHeaderCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return absenceOfSemester!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "absenceTableViewCellID", for: indexPath) as! AbsenceTableViewCell
      
        for absenceByMonth in absenceOfSemester![indexPath.row].absenceByMonths {
            let currentlang = Localize.currentLanguage()
            if currentlang == "ru"{
                cell.subjectLabel.text = absenceByMonth.subjectName_ru
            }else if currentlang == "hy"{
                cell.subjectLabel.text = absenceByMonth.subjectName_hy
            }else {
                cell.subjectLabel.text = absenceByMonth.subjectName_en
            }
              cell.absenceByMonth.append(absenceByMonth)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "absenceTableViewHeaderCell") as! AbsenceTableViewHeaderCell
        headerCell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 0.5)
        headerCell.semesterAbsenceCountLabel.text = "\(absenceOfSemester![0].customabsenceCountOfSemester)"
        headerCell.semesterAbsenceCountLabel.layer.cornerRadius = headerCell.semesterAbsenceCountLabel.frame.size.height / 2
        if (absenceOfSemester![0].customabsenceCountOfSemester > 0 && absenceOfSemester![0].customabsenceCountOfSemester < 50) {
            headerCell.semesterAbsenceCountLabel.backgroundColor = UIColor.red
        }else if (absenceOfSemester![0].customabsenceCountOfSemester > 50 && absenceOfSemester![0].customabsenceCountOfSemester < 70) {
            headerCell.semesterAbsenceCountLabel.backgroundColor = UIColor.lightGray
        }else{
            headerCell.semesterAbsenceCountLabel.backgroundColor = UIColor.green
        }
        headerCell.semesterLabel.text = "Semester".localized() + " \(absenceOfSemester![0].customsemesterNumber)  "
        headerCell.semesterAbsenceLabel.text = "Absence of semester".localized()
        //headerCell.backgroundColor = UIColor.clear
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 1)
        }
    }
    
}
