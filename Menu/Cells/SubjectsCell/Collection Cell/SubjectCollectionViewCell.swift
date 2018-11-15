//
//  SubjectCollectionViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/3/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate {
    
    var subject: [SubjectListOfSemester]? {
        didSet {
            self.subjectTableView.reloadData()
        }
    }

    @IBOutlet weak var subjectTableView: UITableView!
    
    var onClickSubjectTableDone: (( _ subject : SubjectListOfSemester)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        subjectTableView.register(UINib.init(nibName: "SubjectTableViewHederCell", bundle: nil), forCellReuseIdentifier: "subjectHeaderCell")
        subjectTableView.register(UINib.init(nibName: "SubjectTableViewCell", bundle: nil), forCellReuseIdentifier: "subjectTableView")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject!.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectTableView", for: indexPath) as? SubjectTableViewCell
        if indexPath.row  == subject![indexPath.row].customId {
            cell?.contentView.layer.borderWidth = 0.5
            cell?.contentView.layer.borderColor = UIColor.black.cgColor
            cell?.fiilDataOFEachCell(subject: subject![indexPath.row])
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "subjectHeaderCell") as! SubjectTableViewHederCell
        headerCell.backgroundColor = UIColor.init(red: 85, green: 117, blue: 135, alpha: 0.5)
        headerCell.semesterNum.text = "Semester".localized() + " \(subject![0].customSemesterNumber) "
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if  onClickSubjectTableDone != nil {
            onClickSubjectTableDone!(subject![indexPath.row])
        }
    }

}
