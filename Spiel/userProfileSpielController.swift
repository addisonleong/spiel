//
//  userProfileSpielController.swift
//  Spiel
//
//  Created by Addison Leong on 12/3/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class userProfileSpielController: PFQueryTableViewController {
    
    var username = "katherine"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "reloadUserProfile", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handler(notif: NSNotification) {
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
        query.whereKey("user", equalTo: username)
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
        query.orderByDescending("createdAt")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> userProfileCell? {
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? userProfileCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("userProfileCell", owner: self, options: nil)[0] as? userProfileCell
            //cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            cell!.spielTitle?.text = object.valueForKey("title") as? String
            cell!.spielNameDate?.text = "your " + (object["category"] as? String)! + " Spiel"
            
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
            let username = object["user"] as? String
            let query = PFUser.query()
            query?.whereKey("username", equalTo: username!)
            query?.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if let error = error {
                    print(error)
                } else {
                    cell!.profileName = (objects![0]["first_name"] as? String)! + " " + (objects![0]["last_name"] as? String)!
                }
            }
            cell!.deleteButton!.addTarget(self, action: "deleteSpiel:", forControlEvents: .TouchUpInside)
            cell!.spielDescription = (object["description"] as? String)!
            cell!.deleteButton!.buttonId = object.objectId!
            cell!.spielID = (object.valueForKey("objectId") as? String)!
        }
        
        return cell
    }
    
    func deleteSpiel(sender: customButton) {
        let refreshAlert = UIAlertController(title: "Delete This Spiel?", message: "Are you sure you want to delete this Spiel?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            let query = PFQuery(className:"Spiels")
            query.getObjectInBackgroundWithId(sender.buttonId) {
                (object: PFObject?, error: NSError?) -> Void in
                if error == nil && object != nil {
                    object?.deleteInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
                         NSNotificationCenter.defaultCenter().postNotificationName("reloadUserProfile", object: nil);
                    }
                } else {
                    
                }
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetailFromUser", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func goToProfile(sender:UIButton) {
        self.performSegueWithIdentifier("toProfile", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetailFromUser") {
            if let dvc = segue.destinationViewController as? SpielDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let cellData = tableView.cellForRowAtIndexPath(index) as? userProfileCell
                    dvc.spielID = cellData!.spielID
                }
            }
        }
        else if (segue.identifier == "toProfile") {
            if let dvc = segue.destinationViewController as? userProfileViewController {
                if let profile = sender as? UIButton {
                    dvc.username = profile.titleLabel!.text!
                }
            }
        }
    }
    
}