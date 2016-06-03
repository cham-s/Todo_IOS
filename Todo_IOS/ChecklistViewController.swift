//
//  ChecklistViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 02/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [CheckListItem]()
    
    required init?(coder aDecoder: NSCoder) {
        let item = CheckListItem()
        item.text = "Do the Laundry"
        items.append(item)
        let item2 = CheckListItem()
        item2.text = "Walk the Pet"
        items.append(item)
        
        super.init(coder: aDecoder)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
        }
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        let item = items[indexPath.row]
        label.text = item.text

        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = items[indexPath.row]
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if item.checked {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            item.toggleChecked()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - AddItemViewController Delegate
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}
