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

class ProfileViewController : PFQueryTableViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var facebookButton: UIImageView!
    @IBOutlet weak var twitterButton: UIImageView!
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "User")
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query.cachePolicy = .CacheThenNetwork
        }
        query.orderByDescending("createdAt")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        //if let cityName = object?["city"] as? String{
            name?.text = "Joanne"
        //}
//        if let address = object?["address"] as? String{
//            cell?.meetAddress?.text = address;
//        }
//        if let date = object?["date"] as? String{
//            cell?.meetDate?.text = date;
//        }
//        if let time = object?["time"] as? String{
//            cell?.meetTime?.text = time;
//        }
//        if let people = object?["numberOfComming"] as? Int{
//            cell?.peopleAttending?.text = "\(people)";
//        }
//        
//        if let thumbnail = object?["meetImg"] as? PFFile {
//            
//            thumbnail.getDataInBackgroundWithBlock{
//                (imageData, error) -> Void in
//                if error == nil {
//                    let image = UIImage(data: imageData!)
//                    cell.meetImage.image = image
//                }
//            }
//        }
//    }

    return object
    
    }
}