//
//  SWBottonActionView.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

class SWBottonActionView: UIView {
    
    var doneButton: UIButton!
    var cancelButton: UIButton!
    
    class func view() ->SWBottonActionView {
        let view = SWBottonActionView()
        view.addActionButton()
        return view
    }
    
    class func height() -> Int {        
        return 100
    }    
    
    func addActionButton() {
        let doneButton = UIButton.defaultButton(R.donebtn)
        let cancelButton = UIButton.defaultButton(R.cancelbtn)
        self.addSubview(doneButton)
        self.addSubview(cancelButton)
        
        doneButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.right.equalTo(self.snp.centerX)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.left.equalTo(self.snp.centerX)
        }
        
        self.doneButton = doneButton
        self.cancelButton = cancelButton
    }
}
