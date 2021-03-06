//
//  SpielTableViewController.swift
//  Spiel
//
//  Created by Addison Leong on 11/18/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class SpielTableViewController: PFQueryTableViewController {
    
    @IBOutlet weak var navigationbar: UINavigationItem!
    var users = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigationBackground")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "GoToPost", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handler(notif: NSNotification) {
        //performSegueWithIdentifier("Show Detail", sender: nil)
        self.loadObjects()
    }
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        parseClassName = "Spiels"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parseClassName = "Spiels"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Spiels")
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        /*if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }*/
        query.orderByDescending("createdAt")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> spielCell? {
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? spielCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("spiel", owner: self, options: nil)[0] as? spielCell
            //cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            print(object)
            cell!.spielTitle?.text = object.valueForKey("title") as? String
//            cell!.profileName?.titleLabel!.text = object.valueForKey("user") as? String
            
            let description = object["description"] as? String
            var index = description?.endIndex
            var isLong = false
            if (description?.characters.count > 90) {
                index = description?.startIndex.advancedBy(90)
                isLong = true
            }
            var substring = description?.substringToIndex(index!)
            if (isLong) {
                substring = substring! + "..."
            }
            
            cell!.spielDescription?.text = substring
            //cell!.spielDate?.text = object.valueForKey("createdAt") as? String
            cell!.spielDescriptionFull = (object["description"] as? String)!
            if (object["likes"] != nil) {
                cell!.spielLikeCount?.text = object["likes"] as? String
            }
            else {
                cell!.spielLikeCount?.text = "30 likes"
            }
            
            if (object["comments"] != nil) {
                cell!.spielCommentCount?.text = object["comments"] as? String
            }
            else {
                cell!.spielCommentCount?.text = "10 comments"
            }
            
            if (object["shares"] != nil) {
                cell!.spielShareLabel?.text = object["shares"] as? String
            }
            else {
                cell!.spielShareLabel?.text = "0 shares"
            }
            
            let userImageFile = object["image"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let eventImage = UIImage(data:imageData!)
                    cell!.mainImage!.image = eventImage
                    cell!.mainImage!.layer.cornerRadius = 7
                    cell!.mainImage!.layer.masksToBounds = true
                }
            }
            
            cell!.spielID = (object.valueForKey("objectId") as? String)!
            cell!.spielDate?.text = object["createdAt"] as? String
            
            let username = object["user"] as? String
            let query = PFUser.query()
            query?.whereKey("username", equalTo: username!)
            query?.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if let error = error {
                    print(error)
                } else {
                    let userImageFile = objects![0]["profile_photo"] as! PFFile
                    let username = (objects![0]["first_name"] as? String)! + " " + (objects![0]["last_name"] as? String)!
                    cell!.profileName?.setTitle(username, forState: UIControlState.Normal)
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            let eventImage = UIImage(data:imageData!)
                            cell!.profileImage!.image = eventImage
                            cell!.profileImage!.layer.cornerRadius = 21
                            cell!.profileImage!.layer.masksToBounds = true
                        }
                    }
                }
            }
            cell!.profileName!.addTarget(self, action: "goToProfile:", forControlEvents: .TouchUpInside)
            cell!.spielID = object.objectId!
            if (!users.contains((object["user"] as? String)!)) {
                users.append((object["user"] as? String)!)
            }
            cell!.profileName!.tag = users.indexOf((object["user"] as? String)!)!
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("Show Detail", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func goToProfile(sender:UIButton) {
        self.performSegueWithIdentifier("toProfile", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Show Detail") {
            if let dvc = segue.destinationViewController as? SpielDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let cellData = tableView.cellForRowAtIndexPath(index) as? spielCell
                    dvc.spielID = cellData!.spielID
                }
                else {
                    /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    dvc.spielID = appDelegate.posted*/
                }
            }
        }
        else if (segue.identifier == "toProfile") {
            if let dvc = segue.destinationViewController as? userProfileViewController {
                if let profile = sender as? UIButton {
                    dvc.username = users[profile.tag]
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.currentUserProfileView = users[profile.tag]
                }
            }
        }
    }
    
}