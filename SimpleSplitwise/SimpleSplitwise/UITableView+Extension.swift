//
//  UITableView+Extension.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    public class func cellIdentifier() -> String {
        return  "\(type(of:self))"
    }
    
    public class func cellHeight() -> Float {
        return 39.0
    }
    
    class func defaultCell<Self: UITableViewCell>(for tableView: UITableView) -> Self {
        let identifier = self.cellIdentifier()
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = self.init(style: .default, reuseIdentifier: identifier)
        }        
        guard let defautlCell = cell as? Self else {
            fatalError("Can't Find Cell!!!")
        }
        return defautlCell
    }
}
