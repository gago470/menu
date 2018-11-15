//
//  InfoTableView.swift
//  Menu
//
//  Created by AVROMIC on 2/23/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit

class InfoTableView: UITableView {

    var height: NSLayoutConstraint!
    var botom: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else {return}
        
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.black
        headerLabel.text = "Barev"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
        if let imageView = header.subviews.first as? UIImageView{
            height = imageView.constraints.filter{ $0.identifier == "height" }.first
            botom = header.constraints.filter{ $0.identifier == "botom" }.first
        }
        
        let offsetY = -contentOffset.y
        botom.constant = offsetY >= 0 ? 0 : offsetY / 2
        height?.constant = max(header.bounds.height,header.bounds.height + offsetY)
        
        header.clipsToBounds = offsetY <= 0
    }
}
