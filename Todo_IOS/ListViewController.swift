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
    var category: Category!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
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
            configureCheckMarkForCell(cell, withCheckItemListItem: item)
            item.toggleChecked()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        saveItemsData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveItemsData()
    }
    
    // MARK: - AddItemViewCon‘‘troller Delegate
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishEdittingItem item:CheckListItem) {
        if let index = items.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureCheckMarkForCell(cell, withCheckItemListItem: item)
                tableView.reloadData()
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        saveItemsData()
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
        saveItemsData()
    }
    
    // MARK: - Custom Methods
    
    func configureCheckMarkForCell(cell: UITableViewCell, withCheckItemListItem item: CheckListItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    func saveItemsData() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: "Items")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
        
    }
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentDirectory() as NSString)
        .stringByAppendingString("/Checklists.plist")
    }
    
    func loadItems() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                items = unarchiver.decodeObjectForKey("Items") as! [CheckListItem]
                unarchiver.finishDecoding()
            }
        }
    }
}
