//
//  ToolBarViewController.swift
//  SixelConsultig
//
//  Created by Gohar on 10/27/17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import UIKit

class ToolBarViewController: UIViewController {

    var rightItems:[UIBarButtonItem]? {
        didSet {
            setBarButtonItems()
        }
    }
    
    var leftItems: [UIBarButtonItem]? {
        didSet {
            setBarButtonItems()
        }
    }
    
    // common toolbar
    @IBOutlet weak var toolBar: UIToolbar? {
        didSet {
            toolBar?.isTranslucent = false
            toolBar?.tintColor = UIColor.black
           // toolBar?.backgroundColor = UIColor.lightGray
            toolBar?.setBackgroundImage(UIImage(named: "toolbarBG"), forToolbarPosition: .top, barMetrics: .default)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBarButtonItems() {
        var barItems = [UIBarButtonItem]()
        
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if let leftItems_ = leftItems, leftItems_.count != 0 {
            barItems.append(contentsOf: leftItems_)
            barItems.append(spaceItem)
        }
        
        if self.title != nil {
            
            let titleItem = UIBarButtonItem.init(title: self.title!, style: .plain, target: self, action: nil)
            barItems.append(titleItem)
            barItems.append(spaceItem)
        }
        
        if let rightItems_ = rightItems, rightItems_.count != 0 {
            barItems.append(contentsOf: rightItems_)
        }
        
        self.toolBar?.setItems(barItems, animated: true)
    }
}
