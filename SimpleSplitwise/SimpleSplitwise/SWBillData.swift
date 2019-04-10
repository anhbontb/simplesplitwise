//
//  SWBillInfo.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation

class SWBillData {
    var groupId: Int64 = 0
    var createDate = Date()
    var paider: String?
    var members = [String]()
    var billDescription: String?
    var amount: Float = 0
    var amountDetail =  [String: Float]()
    
    lazy var date: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: createDate)        
    }()
}
