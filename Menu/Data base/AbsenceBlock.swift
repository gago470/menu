//
//  AbsenceBlock.swift
//  Menu
//
//  Created by AVROMIC on 3/27/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift


class AbsenceBlock: Object {
    
    @objc dynamic var editData: Int = 0
    @objc dynamic var absenceCount: Int = 0
    let absenceBySemesters = List<AbsenceBySemesters>()
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.editData = json["edit_data"] as? Int ?? 0
        self.absenceCount = json["absenceCount"] as? Int ?? 0
        
        let absenceSemesters = json["absenceBySemester"] as? [[String: Any]]
        if absenceSemesters != nil {
            for absence in absenceSemesters! {
                let absenc = AbsenceBySemesters.init(json: absence)
                absenc.customID = absenceBySemesters.count
                absenceBySemesters.append(absenc)
            }
        }
       
    }
    
}
class AbsenceBySemesters: Object {
    @objc dynamic var customID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var semesterNumber: Int = 0
    @objc dynamic var absenceCountOfSemester: Int = 0
    let absenceOfSemester = List<AbsenceOfSemester>()
    
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.semesterNumber = json["semesterNumber"] as? Int ?? 0
        self.absenceCountOfSemester = json["absenceCountOfSemester"] as? Int ?? 0
        
        let absenceSemesters = json["absenceOfSemester"] as? [[String: Any]]
        if absenceSemesters != nil {
        for absence in absenceSemesters! {
            let absenc = AbsenceOfSemester.init(json: absence)
            absenc.customsemesterNumber = semesterNumber
            absenc.customabsenceCountOfSemester = absenceCountOfSemester
            absenc.customID = absenceOfSemester.count
            absenceOfSemester.append(absenc)
        }
        }
    }
}

class AbsenceOfSemester: Object {
    
    @objc dynamic var customsemesterNumber: Int = 0
    @objc dynamic var customabsenceCountOfSemester: Int = 0
    @objc dynamic var customID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var subjectName_en = ""
    @objc dynamic var subjectName_ru = ""
    @objc dynamic var subjectName_hy = ""
    let absenceByMonths = List<AbsenceByMonth>()
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.subjectName_en = json["subjectName_en"] as? String ?? ""
        self.subjectName_ru = json["subjectName_ru"] as? String ?? ""
        self.subjectName_hy = json["subjectName_hy"] as? String ?? ""
        
        let absenceByMonth = json["absenceByMonths"] as? [[String: Any]]
        
        for absence in absenceByMonth! {
            let absenc = AbsenceByMonth.init(json: absence)
            absenc.customID = absenceByMonths.count
            absenc.subjectName_en = subjectName_en
            absenc.subjectName_hy = subjectName_hy
            absenc.subjectName_ru = subjectName_ru
            absenceByMonths.append(absenc)
        }
    }
}
class AbsenceByMonth: Object {
    
    @objc dynamic var subjectName_en = ""
    @objc dynamic var subjectName_ru = ""
    @objc dynamic var subjectName_hy = ""
    @objc dynamic var customID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var absenceCount: Int = 0
    @objc dynamic var month_en = ""
    @objc dynamic var month_ru = ""
    @objc dynamic var month_hy = ""
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.absenceCount = json["absenceCount"] as? Int ?? 0
        self.month_en = json["month_en"] as? String ?? ""
        self.month_ru = json["month_ru"] as? String ?? ""
        self.month_hy = json["month_hy"] as? String ?? ""
    }
}
