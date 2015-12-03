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

class addSpielController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var username = String()
    
    @IBOutlet weak var spielImage:UIButton!
    @IBOutlet weak var imagePreview:UIImageView!
    @IBOutlet weak var spielTitle:UITextField!
    @IBOutlet weak var spielDescription:UITextView!
    @IBOutlet weak var spielCategory:UIPickerView!
    let picker = UIImagePickerController()
    var category = "book"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spielCategory.dataSource = self
        spielCategory.delegate = self
        picker.delegate = self
        spielTitle.delegate = self
        spielDescription.delegate = self
        spielDescription.layer.borderWidth = 2
        spielDescription.layer.borderColor = UIColor(red: 161/255, green: 214/255, blue: 215/255, alpha: 1).CGColor
        spielDescription.layer.cornerRadius = 5
        spielTitle.layer.borderWidth = 2
        spielTitle.layer.borderColor = UIColor(red: 161/255, green: 214/255, blue: 215/255, alpha: 1).CGColor
        spielTitle.layer.cornerRadius = 5
        imagePreview.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func chooseImage(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage]
        imagePreview.image = image as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        category = appDelegate.searchAutocomplete[row]
    }
    
    @IBAction func post(sender: AnyObject) {
        let post = PFObject(className:"Spiels")
        post["user"] = "katherine"
        post["category"] = category
        post["title"] = spielTitle.text
        post["description"] = spielDescription.text
        let imageData = UIImageJPEGRepresentation(imagePreview.image!, 0.5)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        post["image"] = imageFile
        post.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.spielTitle.text = nil
                self.spielDescription.text = nil
                self.imagePreview.image = UIImage(named: "addImage")
                self.tabBarController!.selectedIndex = 0
                /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.posted = post.objectId!*/
                NSNotificationCenter.defaultCenter().postNotificationName("GoToPost", object: nil);
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
}