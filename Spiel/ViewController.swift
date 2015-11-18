//
//  ViewController.swift
//  Spiel
//
//  Created by SunMi Lee on 11/13/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var navigationbar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigationBackground")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

