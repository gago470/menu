//
//  SXDrawerController.swift
//  SixelConsultig
//
//  Created by My Mac on 10/29/17.
//  Copyright © 2017 SixelIT. All rights reserved.
//

import UIKit
import KYDrawerController

class SXDrawerController: KYDrawerController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.drawerWidth = 3 * self.view.frame.size.width / 4
        if let nav = self.mainViewController as? UINavigationController {
            
            let stor = UIStoryboard.init(name: "HomeBoard", bundle: nil)
            if let rootV = stor.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                rootV.elDrawer = self
                nav.viewControllers = [rootV]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func open()  {
        self.setDrawerState(self.drawerState == .closed ? .opened : .closed, animated: true)
    }
}

