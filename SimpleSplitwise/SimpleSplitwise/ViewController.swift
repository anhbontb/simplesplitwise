//
//  ViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTestButton()
    }
    
    func addTestButton()  {
        let button = UIButton.defaultButton()
        button.backgroundColor = UIColor.green
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(44)
            make.center.equalToSuperview()
        }
        
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            let view = SWFriendPickerViewController()
            self?.present(view, animated: true, completion: nil)
        })
    }

}

