//
//  addSpielController.swift
//  Spiel
//
//  Created by Addison Leong on 12/1/15.
//  Copyright © 2015 SunMi Lee. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class addSpielController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var username = String()
    
    @IBOutlet weak var spielImage:UIButton!
    @IBOutlet weak var spielTitle:UITextField!
    @IBOutlet weak var spielDescription:UITextView!
    @IBOutlet weak var spielCategory:UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spielCategory.dataSource = self
        spielCategory.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.searchAutocomplete.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.searchAutocomplete[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}