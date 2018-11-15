//
//  SubjectList.swift
//  Menu
//
//  Created by AVROMIC on 3/28/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class SubjectBlock: Object {
    
    @objc dynamic var editData: Int = 0
    var subjectLists = List<SubjectList>()
    
    convenience init(json: [String: Any]) {
        self.init()
        
        self.editData = json["edit_data"] as? Int ?? 0
        
        let subjectList = json["subjectList"] as? [[String: Any]]
        for subjectList in subjectList! {
            let subject = SubjectList.init(json: subjectList)
            subject.customID = subjectLists.count
            subjectLists.append(subject)
        }
    }
}

class SubjectList: Object {
    @objc dynamic var customID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var semesterNumber: Int = 0
    let subjectListOfSemesters = List<SubjectListOfSemester>()
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.semesterNumber = json["semesterNumber"] as? Int ?? 0
        
        let subjectListOfSemester = json["subjectListOfSemester"] as? [[String: Any]]
        for listOfSemester in subjectListOfSemester! {
            let listOfSem = SubjectListOfSemester.init(json: listOfSemester)
            listOfSem.customId = subjectListOfSemesters.count
            listOfSem.customSemesterNumber = semesterNumber
            subjectListOfSemesters.append(listOfSem)
        }
    }
}

class SubjectListOfSemester: Object {
    
    @objc dynamic var customSemesterNumber: Int = 0
    @objc dynamic var customId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var subjectName_en: String = ""
    @objc dynamic var subjectName_ru: String = ""
    @objc dynamic var subjectName_hy: String = ""
    @objc dynamic var credit: Int = 0
    @objc dynamic var exType_en: String = ""
    @objc dynamic var exType_ru: String = ""
    @objc dynamic var exType_hy: String = ""
    @objc dynamic var hours: Int = 0
    
    @objc dynamic var detailsOfSubject: DetailsOfSubject?
    
    convenience  init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.subjectName_en = json["subjectName_en"] as? String ?? ""
        self.subjectName_ru = json["subjectName_ru"] as? String ?? ""
        self.subjectName_hy = json["subjectName_hy"] as? String ?? ""
        self.credit = json["credit"] as? Int ?? 0
        self.exType_en = json["exType_en"] as? String ?? ""
        self.exType_ru = json["exType_ru"] as? String ?? ""
        self.exType_hy = json["exType_hy"] as? String ?? ""
        self.hours = json["hours"] as? Int ?? 0
        
        if let subjectListOf = json["detailsOfSubject"] as? [String: Any] {
            print(subjectListOf)
            detailsOfSubject = DetailsOfSubject.init(json: subjectListOf)
        }
    }
}





