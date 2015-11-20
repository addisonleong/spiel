//
//  profile.swift
//  Spiel
//
//  Created by Joanne Jungwon Jang on 11/20/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import ParseCrashReporting

class profile: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var facebookButton: UIImageView!
    @IBOutlet weak var twitterButton: UIImageView!
}