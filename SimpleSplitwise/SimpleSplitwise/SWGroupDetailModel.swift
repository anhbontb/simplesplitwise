//
//  SWGroupDetailModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift

class SWGroupDetailModel {
    let db = SWDatabase()
    
    var group: SWGroupData!
    var dataSource = [SWBillData]()
    var membersDetail = [SWGroupOwnerDetail]()
    let dataSourceSignal = PublishSubject<[SWBillData]>()
    
    deinit {
        self.dataSourceSignal.onCompleted()
    }

    func addBill(_ bill: SWBillData) {
        let billInfo = SWBillInfo.fromBillData(bill)
        self.db.add(data: billInfo)
        
        dataSource.insert(bill, at: 0)
        updateGroupDataSource(dataSource)
    }
    
    func loadData() {
        guard let bills: [SWBillInfo] = self.db.getAllData(query:"groupId = \(group.groupId)") else {
            return
        }
        let data = bills.map({ $0.toBillData() })
        updateGroupDataSource(data)
    }
    
    func updateGroupDataSource(_ data: [SWBillData]) {
        self.dataSource = data
        self.membersDetail = calculateGroupOwner(self.dataSource)
        self.membersDetail = callculaterRelationShip(self.membersDetail)
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func calculateGroupOwner(_ data: [SWBillData]) -> [SWGroupOwnerDetail]{
        var _return = [SWGroupOwnerDetail]()
        let members = self.group.members ?? []
        
        members.forEach { (m) in
            var totalAmount: Float = 0
            data.forEach { (bill) in
                let amountByPersion = (bill.amountDetail[m] ?? 0)
                let amount = bill.paider == m ? bill.amount - amountByPersion: -amountByPersion
                totalAmount = totalAmount + amount
            }
            
            let detail = SWGroupOwnerDetail()
            detail.name = m
            detail.amount = totalAmount
            detail.calculateAmount = totalAmount
            _return.append(detail)
        }
        return _return
    }
    
    func callculaterRelationShip(_ data: [SWGroupOwnerDetail]) -> [SWGroupOwnerDetail] {
        var _return = [SWGroupOwnerDetail]()
        var owner = data.filter({$0.calculateAmount > 0})
        var debtor = data.filter({$0.calculateAmount < 0})
        relationShip(&owner, &debtor, &_return)
        return _return
    }
    
    func relationShip(_ owner: inout [SWGroupOwnerDetail], _ debtor: inout [SWGroupOwnerDetail], _ result: inout [SWGroupOwnerDetail]) {
        if owner.isEmpty || debtor.isEmpty {
            return
        }
        
        let max = owner.max(by: {$0.calculateAmount > $1.calculateAmount})!
        let min = debtor.min(by: {$0.calculateAmount < $1.calculateAmount})!
        
        if (max.calculateAmount > -min.calculateAmount) {
            min.ownerDescription = min.ownerDescription + "owes \(max.name) \(-min.calculateAmount)  "
            max.ownerDescription = max.ownerDescription + "\(min.name) will paid you \(-min.calculateAmount)  "
            max.calculateAmount = max.calculateAmount + min.calculateAmount
            
            owner = owner.filter({$0.name != max.name})
            owner.append(max)
            
            debtor = debtor.filter({$0.name != min.name})
            result.append(min)
            relationShip(&owner, &debtor, &result)
            return
        }
        
        min.ownerDescription = min.ownerDescription + "owes \(max.name) \(max.calculateAmount)  "
        max.ownerDescription = max.ownerDescription + "\(min.name) will paid you \(max.calculateAmount)  "
        min.calculateAmount = max.calculateAmount + min.calculateAmount
        
        owner = owner.filter({$0.name != max.name})
        debtor = debtor.filter({$0.name != min.name})
        if min.calculateAmount == 0 {
            result.append(min)
        } else {
            debtor.append(min)
        }
        
        result.append(max)
        relationShip(&owner, &debtor, &result)        
    }
}
