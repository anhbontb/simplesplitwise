//
//  SWFriendPickerData.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation

class SWFriendPickerData {
    var name = ""
    var selected = false
    
    convenience init(name: String, selected: Bool = false) {
        self.init()
        self.name = name
        self.selected = selected
    }
}
