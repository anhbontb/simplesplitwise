//
//  SWFriend.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RealmSwift

internal class SWFriend: Object {
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    public convenience init(name: String) {
        self.init()
        self.name = name
    }
}
