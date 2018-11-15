//
//  Mother.swift
//  Menu
//
//  Created by AVROMIC on 3/27/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class Mother_EN: Object {
    
    @objc dynamic var fullName = ""
    @objc dynamic var workplace = ""
    @objc dynamic var InStaff = ""
    @objc dynamic var notes = ""
    @objc dynamic var phone = ""
    
    convenience init(json:[String:Any]) {
        self.init()
        self.fullName = json["fullName_en"] as? String ?? ""
        self.workplace = json["workplace_en"] as? String ?? ""
        self.InStaff = json["InStaff_en"] as? String ?? ""
        self.notes = json["notes_en"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
    }
}

class Mother_RU: Object {
    
    
    @objc dynamic var fullName = ""
    @objc dynamic var workplace = ""
    @objc dynamic var InStaff = ""
    @objc dynamic var notes = ""
    @objc dynamic var phone = ""
    
    convenience init(json:[String:Any]) {
        self.init()
        
        self.fullName = json["fullName_ru"] as? String ?? ""
        self.workplace = json["workplace_ru"] as? String ?? ""
        self.InStaff = json["InStaff_ru"] as? String ?? ""
        self.notes = json["notes_ru"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
    }
}

class Mother_HY: Object {
    
   
    @objc dynamic var fullName = ""    
    @objc dynamic var workplace = ""
    @objc dynamic var InStaff = ""
    @objc dynamic var notes = ""
    @objc dynamic var phone = ""
    
    convenience init(json:[String:Any]) {
        self.init()
        
      
        self.fullName = json["fullName_hy"] as? String ?? ""
        self.workplace = json["workplace_hy"] as? String ?? ""
        self.InStaff = json["InStaff_hy"] as? String ?? ""
        self.notes = json["notes_hy"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
    }
}
