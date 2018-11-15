//
//  PersonalData.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 7/16/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift


class PersonalData : Object {
    
    @objc dynamic var ocupation: Bool = false
    @objc dynamic var interest = ""
    var spetialitys = List<Int>()
    var otherSpetialitys = List<String>()
    
    
    convenience init(json:[String:Any]) {
        self.init()
        
//        if let personalData = json["extraInfo"] as? [String: Any]
        
            self.ocupation = json["regularOccupation"] as? Bool ?? false
            self.interest = json["otherInterest"] as? String ?? ""
        
        if let otherSpetiality = json["otherSpeciality"] as? [String] {
            for spetiality in otherSpetiality {
                otherSpetialitys.append(spetiality)
            }
        }
            
            if let spetiality = json["medicalSpecialitiesByIndex"] as? [Int] {
                for spetialityItem in spetiality {
                    spetialitys.append(spetialityItem)
                }
            }
        
    }
}

