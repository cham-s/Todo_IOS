//
//  AddItemViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit


class AddItemViewController: UITableViewController {
    
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }

    
    @IBAction func cancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        print("Item contain in the textfield : \(newItemTextField.text!)")
        dismissViewControllerAnimated(true, completion: nil)
    }
}
