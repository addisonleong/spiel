//
//  searchAutocompleteController.swift
//  Spiel
//
//  Created by Addison Leong on 12/1/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class searchAutocompleteController: UITableViewController {
    
    var username = String()
    var autocomplete = [String]()
    var noresult = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "Search", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handler(notif: NSNotification) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let search = appDelegate.searchSpiel
        if (autocomplete.contains(search)) {
            NSNotificationCenter.defaultCenter().postNotificationName("HideAutocomplete", object: nil);
            return
        }
        else {
            NSNotificationCenter.defaultCenter().postNotificationName("ShowAutocomplete", object: nil);
        }
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getArrayLength()
        if (autocomplete.count == 0) {
            noresult = true
            return 1
        }
        else {
            noresult = false
            return autocomplete.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        getArrayLength()
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var value = String()
        if (noresult == false) {
            value = autocomplete[indexPath.row]
        }
        else {
            value = "No results"
        }
        cell.textLabel!.text = value as? String
        return cell
    }
    
    func getArrayLength() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let search = appDelegate.searchSpiel
        let array = appDelegate.searchAutocomplete
        autocomplete.removeAll()
        for item in array {
            if ((item as NSString).containsString(search)) {
                autocomplete.append(item)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (noresult == true) {
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.searchSpiel = autocomplete[indexPath.row]
        NSNotificationCenter.defaultCenter().postNotificationName("AutocompleteSearch", object: nil);
    }
}