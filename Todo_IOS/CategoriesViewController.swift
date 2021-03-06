//
//  AllListViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, AddCategoryViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedCategory
        
        if index >= 0 && index < dataModel.categories.count {
            let category = dataModel.categories[index]
            performSegueWithIdentifier("ShowList", sender: category)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTabbleView(tableView)
        let category = dataModel.categories[indexPath.row]
        cell.textLabel!.text = category.name
        cell.accessoryType = .DetailDisclosureButton

        return cell
    }
    
    // MARK: - UItableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedCategory = indexPath.row
        let category = dataModel.categories[indexPath.row]
        performSegueWithIdentifier("ShowList", sender: category)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.categories.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("AddCategoryNaviagationController") as! UINavigationController
        let controller = navigationController.topViewController as! AddCategoryViewController
        controller.delegate = self
        let category = dataModel.categories[indexPath.row]
        controller.categoryTodeEdit = category
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - UINavigation Controller Delegate
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == self {
            dataModel.indexOfSelectedCategory = -1
        }
    }
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowList" {
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.category = sender as! Category
        } else if segue.identifier == "AddCategory" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddCategoryViewController
            controller.delegate = self
            controller.categoryTodeEdit = nil
        }
    }
    
    // MARK: - AddCategoryViewController Delegate
    func addCategoryViewControllerDidCancel(controller: AddCategoryViewController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addCategoryViewController(controller: AddCategoryViewController, didFinishAddingCategory category: Category) {
        let newRowIndex = dataModel.categories.count
        dataModel.categories.append(category)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addCategoryViewController(controller: AddCategoryViewController, didFinishEditingCategory category: Category) {
        if let index = dataModel.categories.indexOf(category) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.textLabel!.text = category.name
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Custom Method
    
    func cellForTabbleView(tableview: UITableView) -> UITableViewCell {
        let cellID = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellID) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
    }
}
