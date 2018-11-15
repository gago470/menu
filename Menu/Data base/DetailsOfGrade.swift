//
//  DetailsOfGrade.swift
//  Menu
//
//  Created by AVROMIC on 4/5/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class DetailsOfGrade: Object {
    
     @objc dynamic var givingDate: Int = 0
     @objc dynamic var times: Int = 0

    convenience init(json: [String:Any]) {
        self.init()
        
        self.givingDate = json["givingDate"] as? Int ?? 0
        self.times = json["times"] as? Int ?? 0
        
    }
    
}
