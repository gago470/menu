//
//  ScheduleBlock.swift
//  Menu
//
//  Created by AVROMIC on 3/27/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift

class ScheduleBlock: Object{
    
    @objc dynamic var editDate: Int = 0
    var schedulesList = List<Schedule>()
    
    convenience init(json:[String:Any]) {
        self.init()
        
        self.editDate = json["edit_date"] as? Int ?? 0
        
        let scheduleList = json["schedule"] as? [[String: Any]]
        for schedule in scheduleList! {
            let scheduleModel = Schedule.init(json: schedule)
            scheduleModel.customId = schedulesList.count
            schedulesList.append(scheduleModel)
        }
    }
}

class Schedule: Object {
    @objc dynamic var customId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Int = 0
    var lessonsList = List<Lesson>()
    
    convenience init(json:[String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.date = json["date"] as? Int ?? 0
        
        let lessonList = json["lessons"] as? [[String: Any]]
        for lesson in lessonList! {
            let lessonModel = Lesson.init(json: lesson)
            lessonModel.customDate = date
            lessonModel.customId = lessonsList.count
            lessonsList.append(lessonModel)
        }
    }
}

class Lesson: Object {
    
    @objc dynamic var customDate: Int = 0
    @objc dynamic var customId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var hour = ""
    @objc dynamic var number = ""
    @objc dynamic var subjectName_en = ""
    @objc dynamic var subjectName_ru = ""
    @objc dynamic var subjectName_hy = ""
    @objc dynamic var room = ""
    @objc dynamic var lecture_en = ""
    @objc dynamic var lecture_ru = ""
    @objc dynamic var lecture_hy = ""
    @objc dynamic var corpus_en = ""
    @objc dynamic var corpus_ru = ""
    @objc dynamic var corpus_hy = ""
    
    convenience init(json:[String:Any]) {
        self.init()

        self.id = json["id"] as? Int ?? 0
        self.hour = json["hour"] as? String ?? ""
        self.number = json["number"] as? String ?? ""
        self.subjectName_en = json["subjectName_en"] as? String ?? ""
        self.subjectName_ru = json["subjectName_ru"] as? String ?? ""
        self.subjectName_hy = json["subjectName_hy"] as? String ?? ""
        self.lecture_en = json["lecture_en"] as? String ?? ""
        self.lecture_ru = json["lecture_ru"] as? String ?? ""
        self.lecture_hy = json["lecture_hy"] as? String ?? ""
        self.corpus_en = json["corpus_en"] as? String ?? ""
        self.corpus_ru = json["corpus_ru"] as? String ?? ""
        self.corpus_hy = json["corpus_hy"] as? String ?? ""
        self.room = json["room"] as? String ?? ""
        
    }
}
