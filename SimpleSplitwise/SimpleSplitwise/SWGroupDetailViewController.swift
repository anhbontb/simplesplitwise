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

    var bag = DisposeBag()
    var model = SWGroupDetailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupEvent()
        self.showGroupInfo()
        self.model.loadData()
        
    }
    
    func setupEvent() {
        self.model.dataSourceSignal.subscribe(onNext: { [weak self](data) in
            self?.tableView.reloadData()
        }).disposed(by: self.bag)
    }
    
    func showGroupInfo() {
        self.lbName.text = self.model.group.name
        self.lbDescription.text = self.model.group.description
        self.lbMember.text = self.model.group.members?.joined(separator: ",")
    }
    
    func setGroup(_ group: SWGroupData){
        self.model.group = group
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addGroup = segue.destination as? SWAddBillViewController else {
            return
        }
        setupCallBack(addGroup)
    }
    
    func setupCallBack(_ addGroup: SWAddBillViewController) {
        addGroup.setGroup(self.model.group)
        addGroup.result.subscribe(onNext: { [weak self] (bill) in
            self?.model.addBill(bill)
            self?.popMe()
        }).disposed(by: bag)
    }
}

extension SWGroupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? model.membersDetail.count : model.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ? memberDetailCell(tableView, indexPath) : billInfoCell(tableView, indexPath)
    }
    
    func memberDetailCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        let info = model.membersDetail[indexPath.row]
        cell.textLabel?.text = info.name
        cell.detailTextLabel?.text =  "\(info.amount) : " + info.ownerDescription
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell

    }
    
    func billInfoCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        let info = model.dataSource[indexPath.row]
        cell.textLabel?.text = "\(info.amount) - \(info.paider ?? "") paid - \(info.billDescription ?? "") - \(info.date)"
        cell.detailTextLabel?.text =  "Members: \(info.members.joined(separator: ", "))"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }

}
