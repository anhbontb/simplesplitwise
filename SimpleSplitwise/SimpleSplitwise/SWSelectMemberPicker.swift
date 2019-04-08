//
//  SWSelectMemberPicker.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/8/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SWSelectMemberPicker: SWFriendPickerViewController {
  
    override func addSearchView(){}
    
    override func setupTableViewFrame() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
}

extension SWSelectMemberPicker {
    class func showPick(from: UIViewController,
                        allmembers:[String] ,
                        selectedMenber:[String],
                        multipleSelect: Bool) -> Observable<[SWFriendPickerData]> {
        let model = SWSelectMemberModel()
        model.set(allMember: allmembers, selectedMenber: selectedMenber, multipleSelect: multipleSelect)
        let view = SWSelectMemberPicker()
        view.model = model
        from.navigationController?.pushViewController(view, animated: true)
        return view.result
    }
}
