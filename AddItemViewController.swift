//
//  AddItemViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(controller: AddItemViewController, didFinishEdittingItem item:CheckListItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var newItemTextField: UITextField!
    @IBOutlet weak var doneButtonBar: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            newItemTextField.text = item.text
            doneButtonBar.enabled = true
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        newItemTextField.becomeFirstResponder()
    }

    // MARK: UITexField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneButtonBar.enabled = newText.length > 0
        return true
    }
    
    @IBAction func cancel() {
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = newItemTextField.text!
            delegate?.addItemViewController(self, didFinishEdittingItem: item)
        } else {
            let item = CheckListItem()
            item.text = newItemTextField.text!
            item.checked = false
            delegate?.addItemViewController(self, didFinishAddingItem: item)
        }
    }
}
