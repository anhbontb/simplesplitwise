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
    
    func alert(_ message: String) {
        let alert = UIAlertController.init(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
