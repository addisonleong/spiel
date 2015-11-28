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
    
    var username = String()
    
    @IBOutlet weak var profilepic:UIImageView?
    @IBOutlet weak var profilename:UILabel?
    @IBOutlet weak var tagline:UILabel?
    @IBOutlet weak var followers:UILabel?
    @IBOutlet weak var following:UILabel?
    @IBOutlet weak var follow:UIButton?
    @IBOutlet weak var facebook:UIButton?
    @IBOutlet weak var twitter:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
//        profilepic!.layer.cornerRadius = 29
//        profilepic!.layer.masksToBounds = true
//        spielImage!.layer.cornerRadius = 17
//        spielImage!.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadUser() {
        let query = PFUser.query()
        query?.whereKey("username", equalTo: username)
        query?.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print(error)
            } else {
                let user = objects![0]
                self.profilename!.text = (user["first_name"] as? String)! + " " + (user["last_name"] as? String)!
                self.tagline!.text = user["tagline"] as? String
                let userImageFile = user["profile_photo"] as! PFFile
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        let eventImage = UIImage(data:imageData!)
                        self.profilepic!.image = eventImage
                        self.profilepic!.layer.cornerRadius = 45
                        self.profilepic!.layer.masksToBounds = true
                    }
                }
                var following = user["following"] as? String
                var followers = user["followed_by"] as? String
                if (following == nil) {
                    following = "563 following"
                }
                if (followers == nil) {
                    followers = "18k followers"
                }
                self.followers!.text = followers
                self.following!.text = following
            }
        }
    }
    
    
}