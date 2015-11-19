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
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigationBackground")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        // Do any additional setup after loading the view, typically from a nib.
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
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
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
            cell!.spielTitle?.text = object.valueForKey("title") as? String
            cell!.profileName?.text = object.valueForKey("user") as? String
            
            
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
            
            cell!.spielDescription?.text = substring as? String!
            //cell!.spielDate?.text = object.valueForKey("createdAt") as? String
            if (object["likes"] != nil) {
                cell!.spielLikeCount?.text = object["likes"] as? String
            }
            else {
                cell!.spielLikeCount?.text = "0"
            }
//            let priority = object["priority"] as? String
//            cell!.detailTextLabel?.text = "Priority \(priority)"
        }
        
        return cell
    }
}