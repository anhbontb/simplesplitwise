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

internal class SWGroupInfo: Object {
    @objc dynamic var groupId: Int = 0
    @objc dynamic var groupName: String?
    @objc dynamic var groupDescription: String?
    var groupMembers: List<String>?
    
    override static func primaryKey() -> String? {
        return "groupId"
    }    
}
