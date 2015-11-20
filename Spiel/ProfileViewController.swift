//
//  ProfileViewController.swift
//  Spiel
//
//  Created by SunMi Lee on 11/20/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class ProfileViewController : UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var facebookButton: UIImageView!
    @IBOutlet weak var twitterButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func queryForTable() -> PFQuery {
//        let query = PFQuery(className: "User")
//        // If no objects are loaded in memory, we look to the cache first to fill the table
//        // and then subsequently do a query against the network.
//        if self.objects!.count == 0 {
//            query.cachePolicy = .CacheThenNetwork
//        }
//        query.orderByDescending("createdAt")
//        return query
//    }
    
}