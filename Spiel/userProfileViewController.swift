//
//  userProfileViewController.swift
//  Spiel
//
//  Created by Addison Leong on 11/25/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class userProfileViewController: UIViewController {
    
    var userName = String()
    var userSummary = String()
    var spielID = String()
    var userPic = UIImage()
    var spielDate1 = String()
    var spielTitle1 = String()
    var spielImage1 = UIImage()
    var spielDescription1 = String()
    var spielComments1 = String()
    var spielLikes1 = String()
    
    @IBOutlet weak var profilepic:UIImageView?
    @IBOutlet weak var profilename:UIButton?
    @IBOutlet weak var spielDate:UILabel?
    @IBOutlet weak var spielTitle:UILabel?
    @IBOutlet weak var spielImage:UIImageView?
    @IBOutlet weak var spielDescription:UILabel?
    @IBOutlet weak var spielComments:UILabel?
    @IBOutlet weak var spielLikes:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilepic!.image = userPic
        profilename?.setTitle(userName, forState: UIControlState.Normal)
        spielDate!.text = spielDate1
        spielTitle!.text = spielTitle1
        spielImage!.image = spielImage1
        spielDescription!.text = spielDescription1
        spielComments!.text = spielComments1
        spielLikes!.text = spielLikes1
        profilepic!.layer.cornerRadius = 29
        profilepic!.layer.masksToBounds = true
        spielImage!.layer.cornerRadius = 17
        spielImage!.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}