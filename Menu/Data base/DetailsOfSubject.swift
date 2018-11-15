//
//  DetailsOfSubject
//  Menu
//
//  Created by AVROMIC on 3/28/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class DetailsOfSubject: Object {
    
    @objc dynamic var profession_en: String = ""
    @objc dynamic var profession_ru: String = ""
    @objc dynamic var profession_hy: String = ""
    @objc dynamic var semester_en: String = ""
    @objc dynamic var semester_ru: String = ""
    @objc dynamic var semester_hy: String = ""
    @objc dynamic var stadyLanguage_en: String = ""
    @objc dynamic var stadyLanguage_ru: String = ""
    @objc dynamic var stadyLanguage_hy: String = ""
    @objc dynamic var bySpeciality_en: String = ""
    @objc dynamic var bySpeciality_ru: String = ""
    @objc dynamic var bySpeciality_hy: String = ""
    @objc dynamic var subjectType_en: String = ""
    @objc dynamic var subjectType_ru: String = ""
    @objc dynamic var subjectType_hy: String = ""
    @objc dynamic var subjectTeachingType_en: String = ""
    @objc dynamic var subjectTeachingType_ru: String = ""
    @objc dynamic var subjectTeachingType_hy: String = ""
    @objc dynamic var hours: Int = 0
    @objc dynamic var credit: Int = 0
    @objc dynamic var exType_en: String = ""
    @objc dynamic var exType_ru: String = ""
    @objc dynamic var exType_hy: String = ""
    
    convenience init(json: [String:Any]){
        self.init()
        
        self.profession_en = json["profession_en"] as? String ?? ""
        self.profession_ru = json["profession_ru"] as? String ?? ""
        self.profession_hy = json["profession_hy"] as? String ?? ""
        self.semester_en = json["semester_en"] as? String ?? ""
        self.semester_ru = json["semester_ru"] as? String ?? ""
        self.semester_hy = json["semester_hy"] as? String ?? ""
        self.stadyLanguage_en = json["stadyLanguage_en"] as? String ?? ""
        self.stadyLanguage_ru = json["stadyLanguage_ru"] as? String ?? ""
        self.stadyLanguage_hy = json["stadyLanguage_hy"] as? String ?? ""
        self.bySpeciality_en = json["bySpeciality_en"] as? String ?? ""
        self.bySpeciality_ru = json["bySpeciality_ru"] as? String ?? ""
        self.bySpeciality_hy = json["bySpeciality_hy"] as? String ?? ""
        self.subjectType_en = json["subjectType_en"] as? String ?? ""
        self.subjectType_ru = json["subjectType_ru"] as? String ?? ""
        self.subjectType_hy = json["subjectType_hy"] as? String ?? ""
        self.subjectTeachingType_en = json["subjectTeachingType_en"] as? String ?? ""
        self.subjectTeachingType_ru = json["subjectTeachingType_ru"] as? String ?? ""
        self.subjectTeachingType_hy = json["subjectTeachingType_hy"] as? String ?? ""
        self.hours = json["hours"] as? Int ?? 0
        self.credit = json["credit"] as? Int ?? 0
        self.exType_en = json["exType_en"] as? String ?? ""
        self.exType_ru = json["exType_ru"] as? String ?? ""
        self.exType_hy = json["exType_hy"] as? String ?? ""
    }
}
