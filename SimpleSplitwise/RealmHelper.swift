//
//  RealmHelper.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RealmSwift

public extension Results {
    public func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
