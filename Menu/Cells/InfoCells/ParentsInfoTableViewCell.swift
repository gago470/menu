//
//  ParentsInfoTableViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/26/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class ParentsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameKey: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var workplaceKey: UILabel!
    @IBOutlet weak var workPlaceLabel: UILabel!
    
    @IBOutlet weak var phoneKey: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var inStaffKey: UILabel!
    @IBOutlet weak var inStaffLabel: UILabel!
    
    @IBOutlet weak var noteKey: UILabel!
    @IBOutlet weak var noteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        fullNameKey.text = "Full name".localized()
        workplaceKey.text = "Workplace".localized()
        inStaffKey.text = "In staff".localized()
        phoneKey.text = "Phone".localized()
        noteKey.text = "Notes".localized()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillDataFather(userData: Any?) {
        guard let nonNilUserData = userData else {return}
        if let uData = nonNilUserData as? Father_EN {
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
        if let uData = nonNilUserData as? Father_RU{
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
        if let uData = nonNilUserData as? Father_HY{
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
    }
    
    func fillDataMother(userData: Any?) {
        guard let nonNilUserData = userData else {return}
        if let uData = nonNilUserData as? Mother_EN {
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
        if let uData = nonNilUserData as? Mother_RU{
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
        if let uData = nonNilUserData as? Mother_HY{
            fullNameLabel.text = uData.fullName
            workPlaceLabel.text = uData.workplace
            phone.text = uData.phone
            inStaffLabel.text = uData.InStaff
            noteLabel.text = uData.notes
        }
    }
}
