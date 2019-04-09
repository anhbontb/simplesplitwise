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
    let dataSourceSignal = PublishSubject<[SWBillData]>()

    func addBill(_ bill: SWBillData) {
        let billInfo = SWBillInfo.fromBillData(bill)
        self.db.add(data: billInfo)
        
        self.dataSource.insert(bill, at: 0)
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func loadData() {
        guard let bills: [SWBillInfo] = self.db.getAllData(query:"groupId = \(group.groupId)") else {
            return
        }
        self.dataSource = bills.map({ $0.toBillData() })
        self.dataSourceSignal.onNext(self.dataSource)
    }
}
