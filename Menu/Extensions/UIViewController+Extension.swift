//
//  UIViewController+Extension.swift
//  SixelConsultig
//
//  Created by My Mac on 10/28/17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import UIKit

extension UIViewController {

    func getViewControllerWithStoryBoard(sbName: String, vcIndentifier: String) -> UIViewController? {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIndentifier)
        return vc
    }
}

