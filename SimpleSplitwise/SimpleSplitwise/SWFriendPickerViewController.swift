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
    
    var tableView: UITableView!
    var doneButton: UIButton!
    var cancelButton: UIButton!
    
    let model = SWFriendPickerModel()
    var bag = DisposeBag()
    var dataSource = [SWFriendPickerData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActionButton()
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
    
    @objc func cancelButtonClick() {
        
    }
    
    @objc func doneButtonClick() {
        
    }
}

extension SWFriendPickerViewController {
    
    func addTableView() {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(self.doneButton.snp.top)
        }
    }
    
    func addActionButton() {
        let doneButton = UIButton.defaultButton(R.donebtn)
        let cancelButton = UIButton.defaultButton(R.cancelbtn)
        self.view.addSubview(doneButton)
        self.view.addSubview(cancelButton)
        
        let height = 100;
        doneButton.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.right.equalTo(self.view.snp.centerX)
            make.height.equalTo(height)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.left.equalTo(self.view.snp.centerX)
            make.height.equalTo(height)
        }
        
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        
        self.doneButton = doneButton
        self.cancelButton = cancelButton
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
