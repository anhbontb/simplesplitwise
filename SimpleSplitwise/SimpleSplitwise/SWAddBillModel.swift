//
//  SWAddBillModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift

class SWAddBillModel {
    var billData = SWBillData()
    var group: SWGroupData!
    var dataSource = [SWBillValueData]()
    let dataSourceSignal = PublishSubject<SWBillData>()

    func selectPaider(_ friend: SWFriendPickerData) {
        self.billData.paider = friend.name
        self.billData.members.removeAll { (name) -> Bool in return name == friend.name }
        self.buildDataSource()
    }
    
    func selectMember(_ friends: [SWFriendPickerData]) {
        self.billData.members = friends.map({$0.name})
        self.buildDataSource()
    }
    
    func selectedDate(_ date: Date) {
        self.billData.createDate = date
    }
    
    func updateAmount(_ amount: String) {
        if let intAmount = Float(amount) {
            self.billData.amount = intAmount
            self.buildDataSource()
        }
    }
    
    func updateBillDescription(_ description: String) {
        self.billData.billDescription = description
    }
    
    func paiderDataSource() -> [String] {
        return self.group.members ?? []
    }
    
    func memberDataSource() -> [String] {
        var members = group.members ?? []
        if let paider = self.billData.paider {
            members.removeAll { (member) -> Bool in
                return member == paider
            }
        }
        return members
    }
    
    func allMembers() -> [String] {
        var member = self.billData.members
        if let paider = self.billData.paider {
            member.insert(paider, at: 0)
        }
        return member
    }
    
    func buildDataSource() {
        let member = allMembers()        
        let userAmount = Float(self.billData.amount)/Float(member.count)        
        self.dataSource = member.map({ (name) -> SWBillValueData in
            let data = SWBillValueData()
            data.name = name
            data.value.onNext(userAmount)
            return data
        })
        self.dataSourceSignal.onNext(self.billData)
    }
    
    func update(amount: String, index: Int) {
        let value = Float(amount) ?? 0
        self.dataSource[index].isEdited = true
        self.dataSource[index].value.onNext(value)

        let remains = self.dataSource.filter {!$0.isEdited}
        
        var editedAmount: Float = 0
        self.dataSource.forEach { (data) in
            if data.isEdited {
                editedAmount = editedAmount + (try! data.value.value())
            }
        }
        
        let remainsAmount = self.billData.amount - editedAmount
        let userAmount = remainsAmount/Float(remains.count)
        self.dataSource.forEach { (data) in
            if data.isEdited == false {
                data.value.onNext(userAmount)
            }
        }
    }
    
    func getBill() -> SWBillData {
        var billValue = [String: Float]()
        self.dataSource.forEach { (data) in
            billValue[data.name] = (try! data.value.value())
        }
        self.billData.amountDetail = billValue
        self.billData.groupId = self.group.groupId
        return self.billData
    }
    
    func setBill(_ data: SWBillData) {
        self.billData = data
    }
}
