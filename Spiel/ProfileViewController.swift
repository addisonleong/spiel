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
    var username = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUser() {
        /*let query = PFUser.query()
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
        }*/
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