//
//  DBTest.swift
//  SimpleSplitwiseTests
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import XCTest
import RealmSwift

@testable import SimpleSplitwise

class TestFriendTable: SWTableProtocol {
    func realmDB() -> Realm {
        
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("TestDB.realm")
        config.inMemoryIdentifier = "TestDBInMemory"
        return try! Realm(configuration: config)
    }
}

class DBTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFriendTable() {
        let nameA = "hello"
        let nameB = "world"
        let friendA = SWFriend.init(name: nameA)
        let friendB = SWFriend.init(name: nameB)
        
        let db = TestFriendTable()
        db.add(data: friendA)
        db.add(data: friendB)
        
        let allFriend: [SWFriend]? = db.getAllData()
        XCTAssert(allFriend?.count == 2, "add friend fail")
        
        let firt = allFriend?.first
        let last = allFriend?.last
        
        XCTAssert(firt?.name == nameA, "data error 1")
        XCTAssert(last?.name == nameB, "data error 2")
    }
    
    func testGroup() {
        
        let members = List<String>()
        members.append("friend A")
        members.append("friend B")
        members.append("friend C")
        
        let group = SWGroupInfo()
        group.groupId = 2
        group.groupDescription = "description"
        group.groupName = "name 2"
        group.groupMembers = members
        
        let db = TestFriendTable()
        db.add(data: group)
        
        let allGroups: [SWGroupInfo]? = db.getAllData()
        let firt = allGroups?.first
        XCTAssert(group.groupName == firt?.groupName, "add group to db fail")
    }

}
