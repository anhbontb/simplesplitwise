//
//  Table.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RealmSwift

public extension Results {
    public func toArray() -> [Element] {
        return compactMap { $0 }
    }
}

protocol SWTableProtocol {
    func realmDB() -> Realm
    func add<T:Object>(data: T)
    func getAllData<T:Object>() -> [T]?
}

extension SWTableProtocol {
    func realmDB() -> Realm {
        return try! Realm()
    }
    
    func getAllData<T:Object>() -> [T]? {
        let realm = realmDB()
        return realm.objects(T.self).toArray()
    }
    
    func add<T:Object>(data: T) {
        let realm = realmDB()
        try? realm.write {
            realm.add(data, update: true)
        }
    }
}

class SWDatabase: SWTableProtocol{}
