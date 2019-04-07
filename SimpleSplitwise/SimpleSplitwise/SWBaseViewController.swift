//
//  SWBaseViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit

public extension UIViewController {    
    func popMe() {
        self.navigationController?.popToViewController(self, animated: true)
    }
}

class SWBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    deinit {
        NSLog("*** deinit \(type(of: self))")
    }
}
