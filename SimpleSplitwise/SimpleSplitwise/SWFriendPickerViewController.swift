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


class SWFriendPickerViewController: UIViewController {
    
    var tableView: UITableView!
    var bottomView: SWBottonActionView!
    
    let model = SWFriendPickerModel()
    var bag = DisposeBag()
    var dataSource = [SWFriendPickerData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addActionButton()
        self.addTableView()
        self.reloadData()
    }
    
    func reloadData() {
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
            make.bottom.equalTo(self.bottomView.snp.top)
        }
    }
    
    func addActionButton() {
        let bottomView = SWBottonActionView.view()
        self.view.addSubview(bottomView)
        
        let height = SWBottonActionView.height()
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(height)
        }
        bottomView.doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        bottomView.cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        self.bottomView = bottomView
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
