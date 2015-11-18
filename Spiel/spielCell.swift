//
//  spielCell.swift
//  Spiel
//
//  Created by Addison Leong on 11/18/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import UIKit

class spielCell: UITableViewCell {
    @IBOutlet weak var mainImage:UIImageView?
    @IBOutlet weak var profileImage:UIImageView?
    @IBOutlet weak var profileName:UILabel?
    @IBOutlet weak var spielDate:UILabel?
    @IBOutlet weak var spielTitle:UILabel?
    @IBOutlet weak var spielDescription:UILabel?
    @IBOutlet weak var spielComments:UIImageView?
    @IBOutlet weak var spielLikes:UIImageView?
    @IBOutlet weak var spielCommentCount:UILabel?
    @IBOutlet weak var spielLikeCount:UILabel?
    @IBOutlet weak var spielShare: UIImageView?
    @IBOutlet weak var spielShareLabel: UILabel?
}
