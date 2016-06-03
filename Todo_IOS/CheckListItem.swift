//
//  CheckListItem.swift
//  Todo_IOS
//
//  Created by cham-s on 03/06/16.
//  Copyright © 2016 StellarTech Media. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        self.checked = !self.checked
    }
}
