//
//  SWGroupBillCell.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/11/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SWGroupBillCell: UITableViewCell {
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.contentView.addSubview(timeLabel);
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-15)
            make.width.equalTo(100)
        }
    }
    
    func setBill(_ info : SWBillData) {
        self.timeLabel.text = info.date
        self.textLabel?.text = "\(info.amount) - \(info.paider ?? "") paid - \(info.billDescription ?? "")"
        self.detailTextLabel?.text =  "\(info.amountDetail.keys.joined(separator: ", "))"
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.detailTextLabel?.adjustsFontSizeToFitWidth = true
        self.accessoryType = .none        
    }
}
