//
//  AllListViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var categories: [Category]
    
    required init?(coder aDecoder: NSCoder) {
        categories = [Category]()
        super.init(coder: aDecoder)
        categories.append(Category(name: "Groceries"))
        categories.append(Category(name: "To Do"))
        categories.append(Category(name: "Movies"))
        categories.append(Category(name: "Coll Apps"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTabbleView(tableView)
        let category = categories[indexPath.row]
        cell.textLabel!.text = category.name
        cell.accessoryType = .DetailDisclosureButton

        return cell
    }
    
    // MARK: - UItableView Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.row]
        performSegueWithIdentifier("ShowList", sender: category)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowList" {
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.category = sender as! Category
        }
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
