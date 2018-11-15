
//
//  AlamofireWrapper.swift
//  TTTAttributedLabel
//
//  Created by My Mac on 11/27/17.
//  Copyright © 2017 My Mac. All rights reserved.
//
import Alamofire
import Foundation

final class AlamofireWrapper:  NSObject {
    
    static let baseUrl:String =   "https://emeduni.com/api" //"http://mess.avromic.com/"
    static let sessionManager = Alamofire.SessionManager.default
    
    class func getRequest(_ strURL: String, params : [String : Any]?, headers: HTTPHeaders?, success:@escaping (Any) -> Void, failure:@escaping (String) -> Void) {
        
        LoadingMontionView.sharedInstance.showActivityIndicator()

        sessionManager.request(self.baseUrl + strURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
            LoadingMontionView.sharedInstance.hideActivityIndicator()

            if response.result.isSuccess {
                if let json = response.result.value {
                    // print("JSON: \(json)")
                    success(json)
                }
            }
            
            if let error = response.result.error {
                failure(error.localizedDescription)
            }
        }
    }
    
class func postRequest(_ strURL: String?, params : [String : Any]?, headers: HTTPHeaders?, success:@escaping (Any,Int) -> Void, failure:@escaping (String,Int) -> Void) {
        let urlString = self.baseUrl + strURL!;
        LoadingMontionView.sharedInstance.showActivityIndicator()
        sessionManager.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default , headers: headers).validate().responseJSON { (response) in
            LoadingMontionView.sharedInstance.hideActivityIndicator()
            if response.result.isSuccess {
                let statusCode = response.response?.statusCode
                //print(response.response?.statusCode,response.description)
               
                if let json = response.result.value {
                    success(json,statusCode!)
                }
            }
            
            if let error = response.result.error {
                let statusCode = response.response?.statusCode
                print(error.localizedDescription)
                LoadingMontionView.sharedInstance.hideActivityIndicator()
                failure(error.localizedDescription,statusCode!
                )
            }
        }
    }
    
class func putRequest(_ strURL: String, params : [String : Any]?, headers: HTTPHeaders? , success:@escaping (Any) -> Void, failure:@escaping (String) -> Void) {
        let urlString = self.baseUrl + strURL;
        sessionManager.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            debugPrint(response)
            LoadingMontionView.sharedInstance.showActivityIndicator()
            if response.result.isSuccess {
                LoadingMontionView.sharedInstance.hideActivityIndicator()

                if let json = response.result.value {
                    success(json)
                }
            }
            
            if let error = response.result.error {
                LoadingMontionView.sharedInstance.hideActivityIndicator()
                failure(error.localizedDescription)
            }
        }
    }
    
    class func deleteRequest(_ strURL: String, params : [String : Any]?, headers: HTTPHeaders? = nil, success:@escaping (Any) -> Void, failure:@escaping (String) -> Void) {
        let urlString = self.baseUrl + strURL;
        
        sessionManager.request(urlString, method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
            debugPrint(response)
            
            if response.result.isSuccess {
                
                if let json = response.result.value {
                    //                    print("JSON: \(json)")
                    success(json)
                }
            }
            
            if let error = response.result.error {
                failure(error.localizedDescription)
            }
        }
    }
}
