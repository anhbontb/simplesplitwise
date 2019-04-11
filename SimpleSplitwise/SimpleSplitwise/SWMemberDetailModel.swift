//
//  SWMemberDetailModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/11/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift

class SWMemberDetailModel {
    private var allBill: [SWBillData]!
    private var member: String!
    var dataSource = [SWMemberDetailData]()
    let dataSourceSignal = PublishSubject<[SWMemberDetailData]>()
    
    deinit {
        self.dataSourceSignal.onCompleted()
    }
    
    func set(groupBill allBills: [SWBillData], member: String) {
        self.member = member
        self.allBill = allBills.filter({ (bill) -> Bool in
            return (bill.amountDetail[member] ?? 0) > 0
        })
    }
    
    func loadData() {
        self.dataSource = self.allBill.map({ (info) -> SWMemberDetailData in
            
            var amount = -(info.amountDetail[self.member] ?? 0)
            if info.paider == self.member {
                amount = info.amount + amount
            }
            
            let memberBill = SWMemberDetailData()
            memberBill.billDescription = "total: \(info.amount) - \(info.paider ?? "") paid - \(info.billDescription ?? "") - \(info.date)"
            memberBill.amount = String(amount)
            memberBill.bill = info
            return memberBill
        })
        
        self.dataSourceSignal.onNext(self.dataSource)
    }        
}
