//
//  SWBillValueCell.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/10/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SWBillValueCell: UITableViewCell {
    let lbName: UILabel =  UILabel()
    let txtValue = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell () {
        self.contentView.addSubview(lbName)
        self.contentView.addSubview(txtValue)
        
        lbName.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.equalTo(0)
            make.right.equalTo(self.contentView.snp.centerX)
        }
        
        txtValue.textAlignment = .right
        txtValue.keyboardType = .numberPad
        txtValue.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
            make.left.equalTo(self.contentView.snp.centerX)
        }
    }
}
