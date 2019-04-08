//
//  SWAddBillViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/8/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SWAddBillViewController: SWBaseViewController {
    var group: SWGroupData!
    var bag = DisposeBag()
    let result = PublishSubject<SWGroupData>()

    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBAction func chooseDateClick(_ sender: Any) {
        
    }
    
    @IBAction func choosePaiderClick(_ sender: Any) {
        SWSelectMemberPicker.showPick(from: self,
                                      allmembers: group.members ?? [],
                                      selectedMenber: [], multipleSelect: false)
                            .subscribe(onNext: {[weak self] (friends) in
                                        self?.popMe()
                            }).disposed(by: bag)
    }
    
    @IBAction func addMemberClick(_ sender: Any) {
        SWSelectMemberPicker.showPick(from: self,
                                      allmembers: group.members ?? [],
                                      selectedMenber: [], multipleSelect: true)
                            .subscribe(onNext: {[weak self] (friends) in
                                        self?.popMe()
                            }).disposed(by: bag)

    }
}

extension SWAddBillViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }    
}
