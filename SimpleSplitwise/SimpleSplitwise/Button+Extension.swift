//
//  Button+Extension.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    public class func defaultButton(_ title: String? = nil) -> UIButton {
        let btn = UIButton()
        btn.defaulStyle()
        if let title = title {
            btn.setTitle(title, for: .normal)
        }        
        return btn
    }
    
    func defaulStyle() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
