//
//  LocalizedLabel.swift
//  Menu
//
//  Created by AVROMIC on 1/15/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

@IBDesignable
class LocalizedLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        var _ = self.text?.localized()
    }
}
