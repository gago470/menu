//
//  GradebySemesters.swift
//  Menu
//
//  Created by AVROMIC on 3/28/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class GradeBlock: Object {
    
    @objc dynamic var editDate: Int = 0
    @objc dynamic var avarageGade: Double = 0
    let gradebySemesters = List<GradebySemesters>()
    
    convenience init(json: [String:Any]){
        self.init()
        
        self.editDate = json["edit_data"] as? Int ?? 0
        self.avarageGade = json["avarageGrade"] as? Double ?? 0
        
        let avarageGrade = json["gradebySemesters"] as? [[String: Any]]
        
        for avarageGr in avarageGrade! {
            let grade = GradebySemesters.init(json: avarageGr)
            grade.customID = gradebySemesters.count
            gradebySemesters.append(grade)
        }
    }
}

class GradebySemesters: Object {
    
    @objc dynamic var customID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var semesterNumber: Int = 0
    @objc dynamic var avarageGadeOfSemester: Double = 0
    
    let gradeOfSemesters = List<GradeOfSemester>()
    
    convenience init(json: [String:Any]){
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.semesterNumber = json["semesterNumber"] as? Int ?? 0
        self.avarageGadeOfSemester = json["avarageGradeOfSemester"] as? Double ?? 0
        
        let gradeOfSemester = json["gradeOfSemester"] as? [[String: Any]]
        
        for gradeOfSem in gradeOfSemester! {
            let grade = GradeOfSemester.init(json: gradeOfSem)
            grade.customSemNumber = semesterNumber
            grade.customAvaraGrade = avarageGadeOfSemester
            grade.customId = gradeOfSemesters.count
            gradeOfSemesters.append(grade)
        }
    }
}

class GradeOfSemester: Object {
    
    @objc dynamic var customAvaraGrade: Double = 0
    @objc dynamic var customSemNumber: Int = 0
    @objc dynamic var customId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var el_exam: Int = 0
    @objc dynamic var grade: Int = 0
    @objc dynamic var  subjectName_en: String = ""
    @objc dynamic var  subjectName_ru: String = ""
    @objc dynamic var  subjectName_hy: String = ""
    @objc dynamic var detailOfGrade: DetailsOfGrade?
   
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.date = json["date"] as? Int ?? 0
        self.el_exam = json["el_exam"] as? Int ?? 0
        self.grade = json["grade"] as? Int ?? 0
        self.subjectName_en = json["subjectName_en"] as? String ?? ""
        self.subjectName_ru = json["subjectName_ru"] as? String ?? ""
        self.subjectName_hy = json["subjectName_hy"] as? String ?? ""
        
        if let details = json["detailsOfGrade"] as? [String: Any] {
            detailOfGrade = DetailsOfGrade.init(json: details)
        }
    }
}
