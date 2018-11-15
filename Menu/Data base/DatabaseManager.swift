//
//  DatabaseManager.swift
//  Menu
//
//  Created by AVROMIC on 4/11/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation

class DatabaseManager{
    static var sharedInstacne_:DatabaseManager? 
    
    class var sharedInstance: DatabaseManager {
        
        if sharedInstacne_ == nil {
            sharedInstacne_ = DatabaseManager()
        }
        return sharedInstacne_!
    }
    
    //MARK: App current user
    var currentInfo: Info? {
        get {
            let info = uiRealm.objects(Info.self)
            return info.first
        }
    }
    //MARK: App current token
    var curerntToken : Token? {
        get{
            let token = uiRealm.objects(Token.self)
            return token.first
        }
    }
}
