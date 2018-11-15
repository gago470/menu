//
//  LoadingMontionView.swift
//  Menu
//
//  Created by AVROMIC on 4/12/18.
//  Copyright © 2018 My Mac. All rights reserved.
//


import UIKit

final class LoadingMontionView: NSObject {
    
    static let sharedInstance = LoadingMontionView()
    var activityIndicator:UIActivityIndicatorView?
    
    func getActivityIndicatorView() -> UIActivityIndicatorView? {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
            activityIndicator?.hidesWhenStopped = true
            DispatchQueue.main.async {
                self.activityIndicator?.frame = (UIApplication.shared.keyWindow?.frame)!
                UIApplication.shared.keyWindow?.addSubview(self.activityIndicator!)
            }
        }
        UIApplication.shared.keyWindow?.bringSubview(toFront: activityIndicator!)
        return activityIndicator
    }
    
    func showActivityIndicator() {
        getActivityIndicatorView()?.startAnimating();
    }
    
    func hideActivityIndicator() {
        getActivityIndicatorView()?.stopAnimating();
    }
}
