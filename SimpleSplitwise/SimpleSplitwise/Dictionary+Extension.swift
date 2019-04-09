//
//  Dictionary+Extension.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation

public extension Dictionary {
    var toString: String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        
        return String.init(data: data, encoding: .utf8)
    }
}
