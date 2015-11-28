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

class userSpielCell: PFTableViewCell {
    @IBOutlet weak var mainImage:UIImageView?
    @IBOutlet weak var spielNameDate:UILabel?
    @IBOutlet weak var spielTitle:UILabel?
    @IBOutlet weak var spielComments:UIImageView?
    @IBOutlet weak var spielLikes:UIImageView?
    @IBOutlet weak var spielCommentCount:UILabel?
    @IBOutlet weak var spielLikeCount:UILabel?
    @IBOutlet weak var spielShare: UIImageView?
    @IBOutlet weak var spielShareLabel: UILabel?
    
    var parseObject:PFObject?
    var spielID = String()
    
    @IBAction func profile(sender: AnyObject) {
        
    }
}