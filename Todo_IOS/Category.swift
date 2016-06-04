//
//  Category.swift
//  Todo_IOS
//
//  Created by gecko on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import UIKit

class Category: NSObject, NSCoding {
    
    var name = ""
    var items = [CheckListItem]()
    
    init(name: String) {
        self.name = name
    }
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [CheckListItem]
        super.init()
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }

}
