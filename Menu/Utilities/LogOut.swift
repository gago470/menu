//
//  LogOut.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 9/11/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import UIKit

class LogOut {
    class var sharedInstance: LogOut {
        struct Singleton {
            static let instance = LogOut()
        }
        return Singleton.instance
    }
    
    func logOut() {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let tmpVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginVC")
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = tmpVC
        UserDefaults.standard.set("", forKey: "token")
        RealmWrapper.sharedInstance.deleteObjectsOfModelInRealmDB(Info.self)
        RealmWrapper.sharedInstance.deleteObjectsOfModelInRealmDB(Token.self)
        UserDefaults.standard.removeObject(forKey: "loggedIn")
    }
}
