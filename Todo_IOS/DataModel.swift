//
//  DataModel.swift
//  Todo_IOS
//
//  Created by cham-s on 05/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import Foundation

class DataModel {
    var categories = [Category]()
    var indexOfSelectedCategory: Int {
        get {
           return NSUserDefaults.standardUserDefaults().integerForKey("CategoryIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "CategoryIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init(){
        loadCategories()
        registerDefaults()
        handleFirstTime()
    }
    
    func saveCategories() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(categories, forKey: "Categories")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func documentDirectory()  -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return paths[0]
    }
    
    func dataFilePath()  -> String {
        return (documentDirectory() as NSString)
            .stringByAppendingString("/Categories")
    }
    
    func loadCategories() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                categories = unarchiver.decodeObjectForKey("Categories") as! [Category]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func registerDefaults() {
        let dictionary = ["CategoryIndex": -1, "FirstTime": true]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let category = Category(name: "List")
            categories.append(category)
            indexOfSelectedCategory = 0
            userDefaults.setBool(false, forKey: "FirsTime")
            userDefaults.synchronize()
        }
        
    }
}