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

class TestFriendTable: SWFriendTableProtocol {}

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
        db.add(friend: friendA)
        db.add(friend: friendB)
        
        let allFriend: [SWFriend]? = db.getAllFriend()
        XCTAssert(allFriend?.count == 2, "add friend fail")
        
        let firt = allFriend?.first
        let last = allFriend?.last
        
        XCTAssert(firt?.name == nameA, "data error 1")
        XCTAssert(last?.name == nameB, "data error 2")
        
    }

}
