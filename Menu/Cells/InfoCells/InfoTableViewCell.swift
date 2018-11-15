//
//  InfoTableViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 4/24/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
   
    @IBOutlet weak var identifierKeyLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    
    @IBOutlet weak var mariedKeyLabel: UILabel!
    @IBOutlet weak var mariedLabel: UILabel!
    
    @IBOutlet weak var hasKidKey: UILabel!
    @IBOutlet weak var hasKid: UILabel!
    
    @IBOutlet weak var birthDateKey: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    
    @IBOutlet weak var birthPlaceKey: UILabel!
    @IBOutlet weak var birthPlace: UILabel!
    
    @IBOutlet weak var sexKey: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var nationalityKey: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    
    @IBOutlet weak var cityzeneshipKey: UILabel!
    @IBOutlet weak var cityzenshipLabel: UILabel!
    
    @IBOutlet weak var registrationKey: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var livingAdressKey: UILabel!
    @IBOutlet weak var livingAdressLabel: UILabel!
    
    @IBOutlet weak var religionKey: UILabel!
    @IBOutlet weak var relogionLabel: UILabel!
    
    @IBOutlet weak var phonKey: UILabel!
    @IBOutlet weak var phonLabel: UILabel!
    
    @IBOutlet weak var emailKey: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var statusKey: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
   let userRU = DatabaseManager.sharedInstance.currentInfo?.userModel_RU
   let userHY = DatabaseManager.sharedInstance.currentInfo?.userModel_HY
   let userEN = DatabaseManager.sharedInstance.currentInfo?.userModel_EN
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keyLabel.text = "Full name".localized()
        //textView.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
        
      
        identifierKeyLabel.text = "Identifier".localized()
        mariedKeyLabel.text = "Married".localized()
        hasKidKey.text = "Has kid".localized()
        birthDateKey.text = "Birthdate".localized()
        birthPlaceKey.text = "Birthplace".localized()
        sexKey.text = "Sex".localized()
        nationalityKey.text = "Nationality".localized()
        cityzeneshipKey.text = "Citizenship".localized()
        registrationKey.text = "Registration".localized()
        livingAdressKey.text = "Living address".localized()
        religionKey.text = "Religion".localized()
        phonKey.text = "Phone".localized()
        emailKey.text = "Email".localized()
        statusKey.text = "Status".localized()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(userData: Any?) {
        guard let nonNilUserData = userData else {return}
        if let uData = nonNilUserData as? User_EN {
            valueLabel.text = uData.fullName + "\n" + (userRU?.fullName)! + "\n" + (userHY?.fullName)!
            identifierLabel.text = String(uData.identifier)
            mariedLabel.text = uData.married
            hasKid.text = uData.hasKid
            birthDate.text = uData.birthdate
            birthPlace.text = uData.birthplace
            sexLabel.text = uData.sex
            nationalityLabel.text = uData.nationality
            cityzenshipLabel.text = uData.citizenship
            registrationLabel.text = uData.registration
            livingAdressLabel.text = uData.livingAddress
            relogionLabel.text = uData.religion
            phonLabel.text = uData.phone
            emailLabel.text = uData.email
            statusLabel.text = uData.status
        }
        if let uData = nonNilUserData as? User_RU {
            valueLabel.text = uData.fullName + "\n" + (userEN?.fullName)! + "\n" + (userHY?.fullName)!
            identifierLabel.text = String(uData.identifier)
            mariedLabel.text = uData.married
            hasKid.text = uData.hasKid
            birthDate.text = uData.birthdate
            birthPlace.text = uData.birthplace
            sexLabel.text = uData.sex
            nationalityLabel.text = uData.nationality
            cityzenshipLabel.text = uData.citizenship
            registrationLabel.text = uData.registration
            livingAdressLabel.text = uData.livingAddress
            relogionLabel.text = uData.religion
            phonLabel.text = uData.phone
            emailLabel.text = uData.email
            statusLabel.text = uData.status
        }
        if let uData = nonNilUserData as? User_HY {
            valueLabel.text = uData.fullName + "\n" + (userRU?.fullName)! + "\n" + (userEN?.fullName)!
            identifierLabel.text = String(uData.identifier)
            mariedLabel.text = uData.married
            hasKid.text = uData.hasKid
            birthDate.text = uData.birthdate
            birthPlace.text = uData.birthplace
            sexLabel.text = uData.sex
            nationalityLabel.text = uData.nationality
            cityzenshipLabel.text = uData.citizenship
            registrationLabel.text = uData.registration
            livingAdressLabel.text = uData.livingAddress
            relogionLabel.text = uData.religion
            phonLabel.text = uData.phone
            emailLabel.text = uData.email
            statusLabel.text = uData.status
        }
    }
}
