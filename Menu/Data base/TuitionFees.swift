//
//  TuitionFees.swift
//  Menu
//
//  Created by AVROMIC on 3/28/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class TuitionFees: Object {
    
    @objc dynamic var edit_data: Int = 0
    @objc dynamic var owed: String = ""
    let contributions = List<Contributions>()
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.owed = json["owed"] as? String ?? ""
        self.edit_data = json["edit_data"] as? Int ?? 0
        
        let contribution = json["contributions"] as? [[String: Any]]
        
        for contribut in contribution! {
            let absenc = Contributions.init(json: contribut)
            contributions.append(absenc)
        }
    }
}

class Contributions: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var payment: String = ""
    @objc dynamic var date: Int = 0
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.payment = json["payment"] as? String ?? ""
        self.date = json["date"] as? Int ?? 0
        
    }
}
