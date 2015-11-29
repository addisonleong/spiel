//
//  SpielDetailViewController.swift
//  Spiel
//
//  Created by SunMi Lee on 11/19/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class SpielDetailViewController: UIViewController {
    
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
        loadSpiel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadSpiel() {
        let query = PFQuery(className: "Spiels")
        query.getObjectInBackgroundWithId(spielID) {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil {
                
                let userImageFile = object!["image"] as! PFFile
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        let spielImage = UIImage(data:imageData!)
                        self.spielImage!.image = spielImage
                    }
                }
                
                let username = object!["user"] as? String
                let query = PFUser.query()
                query?.whereKey("username", equalTo: username!)
                query?.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if let error = error {
                        print(error)
                    } else {
                        let userImageFile = objects![0]["profile_photo"] as! PFFile
                        self.profilename?.setTitle((objects![0]["first_name"] as? String)! + " " + (objects![0]["last_name"] as? String)!, forState: UIControlState.Normal)
                        userImageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) -> Void in
                            if error == nil {
                                let userPic = UIImage(data:imageData!)
                                self.profilepic!.image = userPic
                            }
                        }
                    }
                }
                self.spielDate!.text = object!["createdAt"] as? String
                self.spielTitle!.text = object!["title"] as? String
                
                self.spielDescription!.text = object!["description"] as? String
                
                if (object!["likes"] != nil) {
                    self.spielLikes!.text = object!["likes"] as? String
                }
                else {
                    self.spielLikes!.text = "30 likes"
                }
                
                if (object!["comments"] != nil) {
                    self.spielComments!.text = object!["comments"] as? String
                }
                else {
                    self.spielComments!.text = "10 comments"
                }
                
                self.profilepic!.layer.cornerRadius = 29
                self.profilepic!.layer.masksToBounds = true
                self.spielImage!.layer.cornerRadius = 17
                self.spielImage!.layer.masksToBounds = true
            }
            else {
                print(error)
            }
        }
    }
    
    
}