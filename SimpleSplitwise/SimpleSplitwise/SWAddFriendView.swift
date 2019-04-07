//
//  SWSearchView.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit


class SWAddFriendView: UIView {
    
    var textField: UITextField!
    var addButton: UIButton!
    
    class func view() ->SWAddFriendView {
        let view = SWAddFriendView()
        view.setupView()
        return view
    }
    
    class func height() -> Int {
        return 60
    }
    
    func setupView() {
        self.backgroundColor = .green
        let texField = UITextField.init()
        let addButton = UIButton.defaultButton(R.addbtn)
        self.addSubview(texField)
        self.addSubview(addButton)
        
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        addButton.backgroundColor = UIColor.white
        addButton.setTitleColor(UIColor.blue, for: .normal)
        addButton.roundRect(5)
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.bottom.equalTo(-5)
            make.width.equalTo(120)
        }
        
        texField.backgroundColor = UIColor.white
        texField.roundRect(5)
        texField.placeholder = R.inputFriendName
        texField.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo(addButton.snp.left).offset(-5)
        }
        
        self.textField = texField
        self.addButton = addButton
    }
}
