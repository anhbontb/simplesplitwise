//
//  SWGroupData.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit

class SWGroupData {
    var groupId: Int64 = 0
    var name: String?
    var description: String?
    var members: [String]?
    
    convenience init(name: String, description: String, members: [String]?) {
        self.init()
        self.groupId = Int64(Date().timeIntervalSince1970)
        self.name = name
        self.description = description
        self.members = members
    }
}
