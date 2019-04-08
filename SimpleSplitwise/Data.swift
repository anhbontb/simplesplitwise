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
    @objc dynamic var groupId: Int64 = 0
    @objc dynamic var groupName: String?
    @objc dynamic var groupDescription: String?
    var groupMembers: List<String>?
    
    override static func primaryKey() -> String? {
        return "groupId"
    }
    
    func setMembers(_ members: [String]?) {
        guard let members = members else {
            return
        }
        let list = List<String>()
        members.forEach { (oneMember) in
            list.append(oneMember)
        }
        self.groupMembers = list
    }
}
