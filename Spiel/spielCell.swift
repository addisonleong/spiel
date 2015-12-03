//
//  spielCell.swift
//  Spiel
//
//  Created by Addison Leong on 11/18/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse
import Social

class spielCell: PFTableViewCell {
    @IBOutlet weak var mainImage:UIImageView?
    @IBOutlet weak var profileImage:UIImageView?
    @IBOutlet weak var profileName:UIButton?
    @IBOutlet weak var spielDate:UILabel?
    @IBOutlet weak var spielTitle:UILabel?
    @IBOutlet weak var spielDescription:UILabel?
    @IBOutlet weak var spielComments:UIImageView?
    @IBOutlet weak var spielLikes:UIImageView?
    @IBOutlet weak var spielCommentCount:UILabel?
    @IBOutlet weak var spielLikeCount:UILabel?
    @IBAction func share(sender: AnyObject) {
        let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)

        var text = "Check this out!"
        text += "\n-\n" + profileName!.currentTitle! + ": [" + spielTitle!.text! + "] " + spielDescription!.text! + " - Read More on Spiel"
        facebookSheet.setInitialText(text)
        facebookSheet.addImage(mainImage!.image)
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(facebookSheet, animated: true, completion: nil)
    }
    @IBAction func like(sender: AnyObject) {
    }
    @IBAction func comment(sender: AnyObject) {
    }
    @IBOutlet weak var spielShare: UIImageView?
    @IBOutlet weak var spielShareLabel: UILabel?
    
    var parseObject:PFObject?
    var spielID = String()
    var spielDescriptionFull = String()
    
    @IBAction func profile(sender: AnyObject) {
        
    }
}
