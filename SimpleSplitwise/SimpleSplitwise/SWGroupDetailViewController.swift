//
//  SWGroupDetailViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import RxSwift
class SWGroupDetailViewController: SWBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbMember: UILabel!

    var group: SWGroupData!
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.showGroupInfo()
    }
    
    func showGroupInfo() {
        self.lbName.text = group.name
        self.lbDescription.text = group.description
        self.lbMember.text = group.members?.joined(separator: ",")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addGroup = segue.destination as? SWAddBillViewController else {
            return
        }
        setupCallBack(addGroup)
    }
    
    func setupCallBack(_ addGroup: SWAddBillViewController) {
        addGroup.setGroup(group)
        addGroup.result.subscribe(onNext: { [weak self] (groupData) in
            self?.popMe()
        }).disposed(by: bag)
    }
}

extension SWGroupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }    
}
