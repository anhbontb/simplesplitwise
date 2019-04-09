//
//  SWBillInfo.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation

class SWBillData {
    var group: SWGroupData!
    var paider: String?
    var member = [String]()
    var billDescription: String?
    var amount: Float = 0
    var amountDetail =  [String: Int]()
}
