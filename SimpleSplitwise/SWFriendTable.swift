//
//  SWFriendTable.swift
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

protocol SWFriendTableProtocol {
    func realmDB() -> Realm
    func getAllFriend() -> [SWFriend]?
    func add(friend: SWFriend)
}

extension SWFriendTableProtocol {

    func realmDB() -> Realm {
        return try! Realm()
    }
    
    func getAllFriend() -> [SWFriend]? {
        let realm = realmDB()
        return realm.objects(SWFriend.self).toArray()
    }
    
    func add(friend: SWFriend) {
        let realm = realmDB()
        try? realm.write {
            realm.add(friend, update: true)
        }
    }
  
}
