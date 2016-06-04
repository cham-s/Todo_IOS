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
    
    init(){
        loadCategories()
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
}