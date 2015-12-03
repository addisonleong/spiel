//
//  userSpielCell.swift
//  Spiel
//
//  Created by Addison Leong on 11/27/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse
import Social

class userSpielCell: PFTableViewCell {
    var profileName = String()
    var spielDescription = String()
    @IBOutlet weak var mainImage:UIImageView?
    @IBOutlet weak var spielNameDate:UILabel?
    @IBAction func share(sender: AnyObject) {
        let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        var text = "Check this out!"
        text += "\n-\n" + profileName + ": [" + spielTitle!.text! + "] " + spielDescription + " - Read More on Spiel"
        facebookSheet.setInitialText(text)
        facebookSheet.addImage(mainImage!.image)
        
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(facebookSheet, animated: true, completion: nil)
    }
    @IBOutlet weak var spielTitle:UILabel?
    @IBOutlet weak var spielComments:UIImageView?
    @IBOutlet weak var spielLikes:UIImageView?
    @IBAction func like(sender: AnyObject) {
        
    }
    @IBOutlet weak var spielCommentCount:UILabel?
    @IBOutlet weak var spielLikeCount:UILabel?
    @IBOutlet weak var spielShare: UIImageView?
    @IBOutlet weak var spielShareLabel: UILabel?
    
    var parseObject:PFObject?
    var spielID = String()
    
    @IBAction func profile(sender: AnyObject) {
        
    }
}