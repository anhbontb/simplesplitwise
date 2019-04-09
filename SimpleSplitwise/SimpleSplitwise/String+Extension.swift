//
//  String+Extension.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation

public extension String {
    public func toJson() -> [String: AnyObject] {
        let data = self.data(using: .utf8)
        return data?.toJson() ?? [:]
    }

}
public extension Data {
    public func toJson() -> [String: AnyObject] {
        let jsonObj = (try? JSONSerialization.jsonObject(with: self, options: [])) as? [String: AnyObject]
        return jsonObj ?? [:]
    }
}
