//
// Info.swift
//  Menu
//
//  Created by AVROMIC on 2/6/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Token: Object {
    
    @objc dynamic var token = ""
    @objc dynamic var date:Int = 0
    
    convenience init(json:[String:Any]) {
        self.init()        
        self.token = json["token"] as? String ?? ""
        self.date = json["date"] as? Int ?? 0
        print (date)
    }
}



class Info: Object {
    
    @objc dynamic var userModel_EN: User_EN?
    @objc dynamic var userModel_RU: User_RU?
    @objc dynamic var userModel_HY: User_HY?
    @objc dynamic var tuitionFeesModel: TuitionFees?
    @objc dynamic var absenceModel: AbsenceBlock?
    @objc dynamic var gradeModel: GradeBlock?
    @objc dynamic var sheduleList: ScheduleBlock?
    @objc dynamic var subjectList: SubjectBlock?
    @objc dynamic var personalData: PersonalData?
    
    var medicalProfessions_en = List<String>()
    var medicalProfessions_ru = List<String>()
    var medicalProfessions_hy = List<String>()
    
    convenience init(json:[String:Any]) {
        self.init()
        
       
        
        
        if let userData = json["user"] as? [String: Any] {
            
            let userHY = User_HY.init(json: userData)
            let userRU = User_RU.init(json: userData)
            let userEN = User_EN.init(json: userData)
           // let personData = PersonalData.init(json: userData)
            userModel_EN = userEN
            userModel_RU = userRU
            userModel_HY = userHY
          //  personalData = personData
            
            
            userHY.father = Father_HY.init(json: (userData["father"] as? [String: Any])!)
            userRU.father = Father_RU.init(json: (userData["father"] as? [String: Any])!)
            userEN.father = Father_EN.init(json: (userData["father"] as? [String: Any])!)
            userEN.mather = Mother_EN.init(json: (userData["mother"] as? [String: Any])!)
            userRU.mather = Mother_RU.init(json: (userData["mother"] as? [String: Any])!)
            userHY.mather = Mother_HY.init(json: (userData["mother"] as? [String: Any])!)
            
            
            if let persInfo = json["extraInfo"] as? [String:Any] {
                personalData = PersonalData.init(json: persInfo)
            }
           
            if let medicalprofessionHy = userData["medicalProfessions_hy"] as? [String] {
                for profession in medicalprofessionHy {
                    medicalProfessions_hy.append(profession)
                }
            }
            
            if let medicalprofessionRu = userData["medicalProfessions_ru"] as? [String] {
                for profession in medicalprofessionRu {
                    medicalProfessions_ru.append(profession)
                }
            }
            
            
            if let medicalprofessionEn = userData["medicalProfessions_en"] as? [String] {
                for profession in medicalprofessionEn {
                    medicalProfessions_en.append(profession)
                }
            }

            
//            let medicalprofessionEn = json: (userData["medicalProfessions_en"] as? [String])
//
//            for profession in medicalprofessionEn {
//                medicalProfessions_en.append(profession)
//            }
            
        }
        
        if let tuitionFeesData = json["tuitionFees"] as? [String: Any] {
            tuitionFeesModel = TuitionFees.init(json: tuitionFeesData)
        }
        
        if let shedulData = json["scheduleBlock"] as? [String: Any] {
                sheduleList = ScheduleBlock.init(json: shedulData)
        }
        
        if let absenceData = json["absenceBlock"] as? [String: Any]{
            absenceModel = AbsenceBlock.init(json: absenceData)
        }
        
        if let gradeData = json["gradeBlock"] as? [String:Any] {
            gradeModel = GradeBlock.init(json: gradeData)
        }
        
        if let subjData = json["subjectBlock"] as? [String: Any] {
                subjectList = SubjectBlock.init(json: subjData)
        }
    }
}

class User_EN: Object {
    
    @objc dynamic var editData: Int = 0
    @objc dynamic var username = ""
    @objc dynamic var userPhoto = ""
    @objc dynamic var course:Int = 0
    @objc dynamic var fullName = ""
    @objc dynamic var identifier:Int = 0
    @objc dynamic var married = ""
    @objc dynamic var hasKid = ""
    @objc dynamic var birthdate = ""
    @objc dynamic var birthplace = ""
    @objc dynamic var sex = ""
    @objc dynamic var nationality = ""
    @objc dynamic var citizenship = ""
    @objc dynamic var registration = ""
    @objc dynamic var livingAddress = ""
    @objc dynamic var religion = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var status = ""
    
    @objc dynamic var father:Father_EN?
    @objc dynamic var mather:Mother_EN?
    
    convenience init(json:[String:Any]) {
        self.init()
        
        self.editData = json["edit_data"] as? Int ?? 0
        self.username = json["username_en"] as? String ?? ""
        self.userPhoto = json["userPhoto"] as? String ?? ""
        self.course = json["course"] as? Int ?? 0
        self.fullName = json["fullName_en"] as? String ?? ""
        
        self.identifier = json["identifier"] as? Int ?? 0
        self.married = json["married_en"] as? String ?? ""
        self.hasKid = json["hasKid_en"] as? String ?? ""
        self.birthdate = json["birthdate"] as? String ?? ""
        self.birthplace = json["birthplace_en"] as? String ?? ""
        self.sex = json["sex_en"] as? String ?? ""
        self.nationality = json["nationality_en"] as? String ?? ""
        self.citizenship = json["citizenship_en"] as? String ?? ""
        self.registration = json["registration_en"] as? String ?? ""
        self.livingAddress = json["livingAddress_en"] as? String ?? ""
        self.religion = json["religion_en"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.status = json["status_en"] as? String ?? ""
       
    }
}

class User_HY: Object {
    
    @objc dynamic var editData: Int = 0
    @objc dynamic var username = ""
    @objc dynamic var userPhoto = ""
    @objc dynamic var course:Int = 0
    @objc dynamic var fullName = ""
    @objc dynamic var identifier:Int = 0
    @objc dynamic var married = ""
    @objc dynamic var hasKid = ""
    @objc dynamic var birthdate = ""
    @objc dynamic var birthplace = ""
    @objc dynamic var sex = ""
    @objc dynamic var nationality = ""
    @objc dynamic var citizenship = ""
    @objc dynamic var registration = ""
    @objc dynamic var livingAddress = ""
    @objc dynamic var religion = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var status = ""
    
    @objc dynamic var father:Father_HY?
    @objc dynamic var mather:Mother_HY?
    
   
    
    convenience init(json:[String:Any]) {
        self.init()
        
        self.editData = json["edit_data"] as? Int ?? 0
        self.username = json["username_hy"] as? String ?? ""
        self.userPhoto = json["userPhoto"] as? String ?? ""
        self.course = json["course"] as? Int ?? 0
        self.fullName = json["fullName_hy"] as? String ?? ""
        self.identifier = json["identifier"] as? Int ?? 0
        self.married = json["married_hy"] as? String ?? ""
        self.hasKid = json["hasKid_hy"] as? String ?? ""
        self.birthdate = json["birthdate"] as? String ?? ""
        self.birthplace = json["birthplace_hy"] as? String ?? ""
        self.sex = json["sex_hy"] as? String ?? ""
        self.nationality = json["nationality_hy"] as? String ?? ""
        self.citizenship = json["citizenship_hy"] as? String ?? ""
        self.registration = json["registration_hy"] as? String ?? ""
        self.livingAddress = json["livingAddress_hy"] as? String ?? ""
        self.religion = json["religion_hy"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.status = json["status_hy"] as? String ?? ""
    }
    
}

class User_RU: Object {
    
    @objc dynamic var editData: Int = 0
   
    @objc dynamic var username = ""
    @objc dynamic var userPhoto = ""
    @objc dynamic var course:Int = 0
    @objc dynamic var fullName = ""
    @objc dynamic var identifier:Int = 0
    @objc dynamic var married = ""
    @objc dynamic var hasKid = ""
    @objc dynamic var birthdate = ""
    @objc dynamic var birthplace = ""
    @objc dynamic var sex = ""
    @objc dynamic var nationality = ""
    @objc dynamic var citizenship = ""
    @objc dynamic var registration = ""
    @objc dynamic var livingAddress = ""
    @objc dynamic var religion = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var status = ""
    
    @objc dynamic var father:Father_RU?
    @objc dynamic var mather:Mother_RU?
    
    convenience init(json:[String:Any]) {
        self.init()
        self.editData = json["edit_data"] as? Int ?? 0
        self.username = json["username_ru"] as? String ?? ""
        self.userPhoto = json["userPhoto"] as? String ?? ""
        self.course = json["course"] as? Int ?? 0
        self.fullName = json["fullName_ru"] as? String ?? ""
        self.identifier = json["identifier"] as? Int ?? 0
        self.married = json["married_ru"] as? String ?? ""
        self.hasKid = json["hasKid_ru"] as? String ?? ""
        self.birthdate = json["birthdate"] as? String ?? ""
        self.birthplace = json["birthplace_ru"] as? String ?? ""
        self.sex = json["sex_ru"] as? String ?? ""
        self.nationality = json["nationality_ru"] as? String ?? ""
        self.citizenship = json["citizenship_ru"] as? String ?? ""
        self.registration = json["registration_ru"] as? String ?? ""
        self.livingAddress = json["livingAddress_ru"] as? String ?? ""
        self.religion = json["religion_ru"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.status = json["status_ru"] as? String ?? ""
        
    }
}

