//
//  SWAddGroupViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import RxSwift

class SWAddGroupViewController: SWBaseViewController {

    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addMemberClick(_ sender: Any) {
        let view = SWFriendPickerViewController()
        self.navigationController?.pushViewController(view, animated: true)
        view.result.subscribe(onNext: { [weak self] (friends) in
            self?.popMe()
        }).disposed(by: self.bag)
    }    
}
