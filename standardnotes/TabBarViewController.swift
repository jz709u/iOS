//
//  TabBarViewController.swift
//  standardnotes
//
//  Created by Mo Bitar on 12/23/16.
//  Copyright © 2016 Standard Notes. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.sharedInstance.signedIn == false {
//            self.selectedIndex = 1
        }
    }


}
