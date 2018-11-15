//
//  RealmWrapper.swift
//  SixelConsultig
//
//  Created by My Mac on 30.10.17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrapper {
    
    class var sharedInstance: RealmWrapper {
        struct Singleton {
            static let instance = RealmWrapper()
        }
        return Singleton.instance
    }
    
    func updateObjectsWithPrinaryKey(completation : ()->Void) {
        do {
            try uiRealm.write({
                completation()
            })
        } catch {
            print("Something went wrong!")
        }
    }
    
    func getObjectFromTable(withPrimaryKey pk:String, objectType:Object.Type ) -> Object {
        var returnObject = Object.init()
        
        let obj = uiRealm.object(ofType: objectType, forPrimaryKey: pk)
        
        if obj != nil {
            returnObject = obj!
        }
        
        return returnObject
    }
    
    func getAllObjectsOfModelFromRealmDB(_ objectType:Object.Type)->[Object] {
        var returnObjects = [Object]()
        
        let objects = uiRealm.objects(objectType)
        
        for object in objects {
            returnObjects.append(object)
        }
        return returnObjects
    }
    
    
    /*static func addCategory(category: CategoryRLM) -> Bool {
     let realm = try! Realm()
     if let existingCategory = realm.object(ofType: CategoryRLM.self, forPrimaryKey: category.name) {
     return false
     }
     try realm.write! {
     realm.add(category)
     }
     return true
     }*/
    
    func addObjectInRealmDB(_ object: Object, update: Bool = false ) {
        do {
            try uiRealm.write({
                uiRealm.add(object, update: update)
            })
        } catch {
            print("Something went wrong!")
        }
    }
    
    func deleteObjectFromRealmDB(_ object: Object)  {
        do {
            try uiRealm.write({
                uiRealm.delete(object)
            })
        } catch {
            print("Something went wrong!")
        }
    }
    
    func deleteObjectsOfModelInRealmDB(_ objectType:Object.Type) -> Void {
        let objects = uiRealm.objects(objectType)
        if objects.count == 0 {
            return
        }
        do {
            try uiRealm.write({
                uiRealm.delete(objects)
            })
        } catch {
            print("Something went wrong!")
        }
    }
    
    func deleteAllFromDB(complation:()->Void )  {
        do {
            try uiRealm.write({
                uiRealm.deleteAll()
                complation()
            })
        } catch {
            print("Something went wrong!")
        }
    }
}
