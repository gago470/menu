//
//  MyTableViewCell.swift
//  Trabsition Test
//
//  Created by ROZA AVAGYAN on 7/3/18.
//  Copyright © 2018 ROZA AVAGYAN. All rights reserved.
//

import UIKit

class SpetialityCell: UITableViewCell {

     var onButtonSelected : (() -> Void)? = nil
     var onButtonDeselect : (()-> Void)? = nil
    
    @IBOutlet weak var label: UILabel!
     @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
        // Configure the view for the selected state
    }
    @IBAction func choosenButton(_ sender: UIButton) {
        if !sender.isSelected  {
            sender.isSelected = true
            self.button.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        if let onButtonSelected = self.onButtonSelected {
            onButtonSelected()
         }
        }else {
            sender.isSelected = false
            self.button.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            if let onButtonDeselect = self.onButtonDeselect {
                onButtonDeselect()
            }
        }
    }
    
}
