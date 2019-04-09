//
//  SWBillValueData.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift

class SWBillValueData {
    var name: String!
    var value = BehaviorSubject<Float>(value: 0)
    var isEdited = false
}
