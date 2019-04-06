//
//  SWFriendPickerViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

fileprivate class SWFriendCell: UITableViewCell {
    func setItem( _ friend: SWFriendPickerData) {
        self.textLabel?.text = friend.name
        self.accessoryType = friend.selected ? .checkmark : .none
    }
}

class SWFriendPickerViewController: UIViewController {
    
    var tableView: UITableView?
    let model = SWFriendPickerModel()
    var bag = DisposeBag()
    var dataSource = [SWFriendPickerData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        self.loadData()
    }
    
    func loadData() {
        self.model.loadDataSource().subscribe(onNext: { [weak self] (data) in
            self?.reloadTableView(data)
        }).disposed(by: self.bag)
    }
    
    func reloadTableView(_ data: [SWFriendPickerData]) {
        self.dataSource = data
        self.tableView?.reloadData()
    }
}

extension SWFriendPickerViewController {
    
    func addTableView() {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
        }
    }
}

extension SWFriendPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SWFriendCell.defaultCell(for: tableView)
        let item = self.dataSource[indexPath.row]
        cell.setItem(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.dataSource[indexPath.row]
        self.dataSource[indexPath.row].selected = !item.selected
        tableView.reloadData()
    }    
}
