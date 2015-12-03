//
//  searchSpielController.swift
//  Spiel
//
//  Created by Addison Leong on 12/1/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class searchSpielController: UIViewController, UISearchBarDelegate {
    
    var username = String()
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autocomplete: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "AutocompleteSearch", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideautocomplete:", name: "HideAutocomplete", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showautocomplete:", name: "ShowAutocomplete", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func hideautocomplete(notif: NSNotification) {
        autocomplete.hidden = true
    }
    
    func showautocomplete(notif: NSNotification) {
        autocomplete.hidden = false
    }
    
    func handler(notif: NSNotification) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        search.text! = appDelegate.searchSpiel
        titleLabel.text = "Trending " + search.text! + " Spiels"
        NSNotificationCenter.defaultCenter().postNotificationName("Search", object: nil);
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.searchSpiel = search.text!
        titleLabel.text = "Trending " + search.text! + " Spiels"
        NSNotificationCenter.defaultCenter().postNotificationName("Search", object: nil);
        search.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.searchSpiel = search.text!
        titleLabel.text = "Trending " + search.text! + " Spiels"
        NSNotificationCenter.defaultCenter().postNotificationName("Search", object: nil);
    }
    
}