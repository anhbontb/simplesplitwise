//
//  SWFriend.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RealmSwift

extension Array where Element: RealmCollectionValue {
    func toList() -> List<Element> {
        let list = List<Element>()
        self.forEach { (ele) in
            list.append(ele)
        }
        return list
    }
}

internal class SWFriendInfo: Object {
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
    var groupMembers: List<String> = List<String>()
    
    override static func primaryKey() -> String? {
        return "groupId"
    }
}


class SWBillInfo: Object {
    @objc dynamic var groupId: Int64 = 0
    @objc dynamic var billId: Int64 = 0
    @objc dynamic var paider: String?
    @objc dynamic var billDescription: String?
    @objc dynamic var amount: Float = 0
    @objc dynamic var amountDetailString: String?
    var members: List<String> = List<String>()
    
    override static func primaryKey() -> String? {
        return "billId"
    }
    
    func getAmountDetail() -> [String: Float]  {
        return amountDetailString?.toJson() as? [String: Float] ?? [String:Float]()
    }
    
    class func fromBillData(_ data: SWBillData) -> SWBillInfo {
        let bill = SWBillInfo()
        bill.amount = data.amount
        bill.groupId = data.groupId
        bill.billId = Int64(Date().timeIntervalSince1970)
        bill.paider = data.paider
        bill.billDescription = data.billDescription
        bill.amountDetailString = data.amountDetail.toString
        bill.members = data.members.toList()
        return bill
    }
    
    func toBillData() -> SWBillData {
        let bill = SWBillData()
        bill.amount = self.amount
        bill.groupId = self.groupId
        bill.paider = self.paider
        bill.billDescription = self.billDescription
        bill.amountDetail = (self.amountDetailString?.toJson() as? [String: Float]) ?? [String: Float]()
        bill.members = self.members.compactMap({$0})
        return bill
    }
}
