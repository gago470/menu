//
//  UserRequestService.swift
//  Menu
//
//  Created by AVROMIC on 3/27/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SConnection

class UserRequestService: NSObject {
    
    static var instance:UserRequestService? = nil
    
    class var sharedInstance: UserRequestService {
        if instance == nil {
            instance = UserRequestService()
        }
        return instance!
    }
    
    var currentInfo: Info? {
        get {
            let info = uiRealm.objects(Info.self)
            return info.first
        }
    }
    
    func login(endpoint:String?,username:String,password:String, succses : @escaping (Any,Int) -> Void , error : @escaping (Any,Int) -> Void) {
        
        AlamofireWrapper.postRequest("/index", params: ["username":username,"password":password], headers: nil, success: { (success,code) in
            let code = code
            let dict = success as? [String:Any]
            if let info = dict!["info"] as? [String:Any] {
                let db = Info.init(json: info)
                RealmWrapper.sharedInstance.deleteObjectsOfModelInRealmDB(Info.self)
                RealmWrapper.sharedInstance.addObjectInRealmDB(db)
            }
            
            if let token = dict!["token"] as? String {
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.synchronize()
            }
            
            if let date = dict!["date"] as? Int {
                UserDefaults.standard.set(date, forKey: "date")
                UserDefaults.standard.synchronize()
            }
            succses(success,code)

        }) { (errorString,code) in
          let code = code
            error(errorString,code)
        }
    }
    
    func updateScheduleDB(endpoint:String?, token: String, editDate: Int?, succsesBlock : @escaping (Any,Int) -> Void, error : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest("/index", params: nil, headers:["token": token,"editDate": String(describing: editDate ?? 0),"block":"schedule"], success: { (success,code) in
            let dict = success as? [String:Any]
            if let info = dict!["scheduleBlock"] as? [String:Any] {
                let db = ScheduleBlock.init(json: info)
                RealmWrapper.sharedInstance.addObjectInRealmDB(db)
                RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey {
                    self.currentInfo?.sheduleList = db
                    succsesBlock(success,code)
                    print(succsesBlock)
                }
            }else {
               succsesBlock(success,code)
            }
        }) { (errorString,code) in
            error(errorString,code)
        }
    }
    
    func updateFeesDb(endpoint:String?,token:String?,editDate:Int?,succsesBlock : @escaping (Any,Int) -> Void , errorBlock : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest("/index" , params: nil, headers: ["token": token ?? "", "editDate": String(describing: editDate ?? 0),"block":"finance"], success: { (success,code) in
            let dict = success as? [String:Any]
            if let info = dict!["tuitionFees"] as? [String:Any] {
                let tuitionFees = TuitionFees.init(json: info)
                RealmWrapper.sharedInstance.addObjectInRealmDB(tuitionFees)
                RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey(completation: {
                    self.currentInfo?.tuitionFeesModel = tuitionFees
                    succsesBlock(success,code)
                })
            }else {
                succsesBlock(success,code)
            }
        }) { (errorString,code) in
            errorBlock(errorString,code)
        }
    }
    
    func updateGradeDb(endpoint:String?,token:String?,editDate:Int?,succsesBlock : @escaping (Any,Int) -> Void , errorBlock : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest("/index", params: nil, headers: ["token": token ?? "", "editDate": String(describing: editDate ?? 0),"block":"grade"], success: { (success,code) in
            let dict = success as? [String:Any]
            if let info = dict!["gradeBlock"] as? [String:Any] {
                let grade = GradeBlock.init(json: info)
                RealmWrapper.sharedInstance.addObjectInRealmDB(grade)
                RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey(completation: {
                    self.currentInfo?.gradeModel = grade
                    succsesBlock(success,code)
                })
            }else {
                succsesBlock(success,code)
            }
            
        }) { (errorString,code) in
            errorBlock(errorString,code)
        }
    }
    
    func updateSubjectDb(endpoint:String?,token:String?,editDate:Int?,succsesBlock : @escaping (Any,Int) -> Void , errorBlock : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest("/index", params: nil, headers: ["token": token ?? "", "editDate": String(describing: editDate ?? 0),"block":"subject"], success: { (success,code) in
            let dict = success as? [String:Any]
            if let info = dict!["subjectBlock"] as? [String:Any] {
                let subject = SubjectBlock.init(json: info)
                RealmWrapper.sharedInstance.addObjectInRealmDB(subject)
                RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey(completation: {
                    self.currentInfo?.subjectList = subject
                    succsesBlock(success,code)
                })
            }else {
                succsesBlock(success,code)
            }
        }) { (errorString,code) in
            errorBlock(errorString,code)
        }
    }
    
    func updateAbsenceDb(endpoint:String?,token:String?,editDate:Int?,succsesBlock : @escaping (Any,Int) -> Void , errorBlock : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest("/index", params: nil, headers: ["token": token ?? "", "editDate": String(describing: editDate ?? 0),"block":"absence"], success: { (success,code) in
            let dict = success as? [String:Any]
            if let info = dict!["absenceBlock"] as? [String:Any] {
                let absence = AbsenceBlock.init(json: info)
                RealmWrapper.sharedInstance.addObjectInRealmDB(absence)
                RealmWrapper.sharedInstance.updateObjectsWithPrinaryKey(completation: {
                    self.currentInfo?.absenceModel = absence
                    succsesBlock(success,code)
                })
            }else {
                succsesBlock(success,code)
            }
        }) { (errorString,code) in
            errorBlock(errorString,code)
        }
    }
    
    func logOut(endpoint:String?,token:String?,editDate:Int?,succsesBlock : @escaping (Any,Int) -> Void , errorBlock : @escaping (Any,Int) -> Void){
        AlamofireWrapper.postRequest(endpoint, params: nil, headers: ["token": token!], success: { (success,code) in
           
            succsesBlock(success,code)
            
        }) { (errorString,code) in
            print("error")
            errorBlock(errorString,code)
        }
    }
    
    
}
