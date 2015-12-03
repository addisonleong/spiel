//
//  trendingSpielSearchController.swift
//  Spiel
//
//  Created by Addison Leong on 12/1/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class trendingSpielViewController: PFQueryTableViewController {
    
    var username = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "Search", object: nil)
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let search = appDelegate.searchSpiel
        query.whereKey("category", equalTo: search)
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
        query.orderByDescending("createdAt")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> userSpielCell? {
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? userSpielCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("userSpiel", owner: self, options: nil)[0] as? userSpielCell
            //cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell to show todo item with a priority at the bottom
        if let object = object {
            cell!.spielTitle?.text = object.valueForKey("title") as? String
            cell!.spielNameDate?.text = (object.valueForKey("user") as? String)! + "'s " + (object["category"] as? String)! + " Spiel"
            
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
            cell!.spielDescription = (object["description"] as? String)!
            
            cell!.spielID = (object.valueForKey("objectId") as? String)!
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetailFromSearch", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func goToProfile(sender:UIButton) {
        self.performSegueWithIdentifier("toProfileFromSearch", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetailFromSearch") {
            if let dvc = segue.destinationViewController as? SpielDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let cellData = tableView.cellForRowAtIndexPath(index) as? userSpielCell
                    dvc.spielID = cellData!.spielID
                }
            }
        }
        else if (segue.identifier == "toProfileFromSearch") {
            if let dvc = segue.destinationViewController as? userProfileViewController {
                if let profile = sender as? UIButton {
                    dvc.username = profile.titleLabel!.text!
                }
            }
        }
    }
    
}