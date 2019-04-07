//
//  UIStoryboard+Extension.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class func currentStoryboard() -> UIStoryboard? {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func viewController(_ name: String) -> UIViewController {
        return instantiateViewController(withIdentifier: name)
    }
}
