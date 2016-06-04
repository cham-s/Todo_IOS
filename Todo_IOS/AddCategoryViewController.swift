//
//  AddCategoryViewController.swift
//  Todo_IOS
//
//  Created by cham-s on 04/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

protocol AddCategoryViewControllerDelegate: class {
    func addCategoryViewControllerDidCancel(controller: AddCategoryViewController)
    func addCategoryViewController(controller: AddCategoryViewController, didFinishAddingCategory category: Category)
    func addCategoryViewController(controller: AddCategoryViewController, didFinishEditingCategory category: Category)
}

class AddCategoryViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    
    weak var delegate: AddCategoryViewControllerDelegate?
    
    var categoryTodeEdit: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = categoryTodeEdit {
            title = "Edit Item"
            categoryTextField.text = category.name
            doneBarButton.enabled = true
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        categoryTextField.becomeFirstResponder()
    }
    
    // MARK: UITexField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = newText.length > 0
        return true
    }
    
    // MARK - Custom Methods
    @IBAction func cancel() {
        delegate?.addCategoryViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let category = categoryTodeEdit {
            category.name = categoryTextField.text!
            delegate?.addCategoryViewController(self, didFinishEditingCategory: category)
        } else {
            let category = Category(name: categoryTextField.text!)
            delegate?.addCategoryViewController(self, didFinishAddingCategory: category)
        }
    }
}
