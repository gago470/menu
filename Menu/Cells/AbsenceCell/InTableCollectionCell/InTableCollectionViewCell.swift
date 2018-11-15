//
//  InTableCollectionViewCell.swift
//  Menu
//
//  Created by ROZA AVAGYAN on 5/7/18.
//  Copyright © 2018 My Mac. All rights reserved.
//

import UIKit
import Localize_Swift

class InTableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var absenceCountLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        absenceCountLabel.layer.cornerRadius = absenceCountLabel.frame.size.height / 2
    }
    
    func feelData (absenc: AbsenceByMonth){
        
        let currentLang = Localize.currentLanguage()
        switch currentLang {
        case "en":
            monthLabel.text = absenc.month_en
            break
        case "hy":
            monthLabel.text = absenc.month_hy
            break
        case "ru":
            monthLabel.text = absenc.month_ru
            
            break
        default:
            monthLabel.text = absenc.month_en
        }
        absenceCountLabel.text = "\(absenc.absenceCount)"
        if (absenc.absenceCount >= 0 && absenc.absenceCount <= 5){
            absenceCountLabel.backgroundColor = UIColor.lightGray
        }else if (absenc.absenceCount > 5 && absenc.absenceCount <= 19) {
            absenceCountLabel.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 1)
        } else{
            absenceCountLabel.backgroundColor = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 1)
        }
    }
}
