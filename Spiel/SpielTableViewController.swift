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
            print(object.valueForKey("title") as? String)
//            let priority = object["priority"] as? String
//            cell!.detailTextLabel?.text = "Priority \(priority)"
        }
        
        return cell
    }
}