//
//  MemberDetailViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/11/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SWMemberDetailViewController: SWBaseViewController {
    var tableView: UITableView!
    var model = SWMemberDetailModel()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        self.setupEvent()
        self.model.loadData()
    }
    
    func setupEvent() {
        self.model.dataSourceSignal
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) in
                self?.tableView.reloadData()
            }).disposed(by: self.bag)
    }
    
    func set(groupBill allBills: [SWBillData], member: String) {
        self.model.set(groupBill: allBills, member: member)
    }
    
    func addTableView() {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        self.tableView = table
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
}

extension SWMemberDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        let item = self.model.dataSource[indexPath.row]
        cell.textLabel?.text = item.amount
        cell.detailTextLabel?.text = item.billDescription
        
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    } 
}

