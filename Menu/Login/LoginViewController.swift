//
//  LoginViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift
import Alamofire
import SConnection
import Toast_Swift

var logedIn = Bool()
//let login = "admin"
//let password = "admin"

class LoginViewController: UIViewController , NSKeyedArchiverDelegate{
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        userNameText.placeholder = "User name".localized()
        passwordText.placeholder = "Password".localized()
        loginButton.text = "Login".localized()
    }
    
    func loginUser(userParam:@escaping(Any) -> Void) {
        guard let userName = userNameText.text else {
            print("usernameerror")
            return
        }
        
        guard let pasSword = passwordText.text else {
            print("usernameerror")
            return
        }
        if !userName.isEmpty && !pasSword.isEmpty{
            
            UserRequestService.sharedInstance.login(endpoint: "", username:  userName, password: pasSword , succses: { (succses,code) in
                let code = code
                if code == 200 {
                    
                   userParam(succses)
                }else {
                    self.toastAdd(messageText: "feild1")
                    
                }
                
                
               
            }) { (error,code) in
                let code = code
                if code == 400 {
                   self.toastAdd(messageText: "Use name or password incorrect, pleas insert correct user name and password")
                }else {
                    self.toastAdd(messageText: "feild")
                    
            }
                print(error)
            }
            
        }else {
            
            return
        }
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        if(SConnection.isConnectedToNetwork()){
            loginUser { (user) in
                let tbstoryboard = UIStoryboard(name: "SXMenuBoard", bundle: nil)
                let tmpVC = tbstoryboard.instantiateViewController(withIdentifier: "SXDrawerController")
                UserDefaults.standard.set(true, forKey: "loggedIn")
                UserDefaults.standard.synchronize()
                self.present(tmpVC, animated: true, completion: nil)
            }            
        }else{
            toastAdd(messageText: "No connection".localized())
        }
        
      
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: UIButton) {
        
    }
    
    @objc func reloadView() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func toastAdd(messageText message : String) {
        // create a new style
        var style = ToastStyle()
        
        // this is just one of many style options
        style.messageColor = .white
        style.backgroundColor = .darkGray
        style.activityBackgroundColor = .black
        
        
        // present the toast with the new style
        self.view.makeToast(message, duration: 5.0, position: .bottom,style: style)
        
        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style
        //  self.view.makeToast("This is a piece of toast") // now uses the shared style
        
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled  = true
        
        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled  = true
    }
}

