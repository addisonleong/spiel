//
//  spielTabBarController.swift
//  Spiel
//
//  Created by Addison Leong on 11/19/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse
import Bolts

class spielTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().barTintColor = UIColor(red: 6/255, green: 185/255, blue: 186/255, alpha: 1)
//        UITabBar.appearance().selectedImageTintColor = UIColor(red: 255/255, green: 147/255, blue: 57/255, alpha: 1)
        UITabBar.appearance().backgroundImage = UIImage(named: "navigationBackground")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}