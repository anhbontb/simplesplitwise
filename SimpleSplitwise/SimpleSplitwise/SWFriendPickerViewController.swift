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
import RxCocoa

class SWFriendPickerViewController: SWBaseViewController {
    
    var tableView: UITableView!
    var searchView: SWAddFriendView!
    let result = PublishSubject<[SWFriendPickerData]>()
    
    let model = SWFriendPickerModel()
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationBarItem()
        self.addSearchView()
        self.addTableView()
        self.setupEvent()
        self.model.loadDataSource()
    }
    
    func setupEvent() {
        self.model.dataSourceSignal
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) in
                self?.tableView.reloadData()
        }).disposed(by: self.bag)
    }
  
    @objc func doneButtonClick() {
        let friends = self.model.selectedFriend()
        self.result.onNext(friends)
        self.result.onCompleted()
    }
    
    @objc func addFriendClick() {
        let name = self.searchView.textField.text
        self.searchView.textField.text = nil
        self.addFriend(name)
    }
    
    func addFriend(_ name: String?) {       
        self.model.addFriend(name)
    }
}

extension SWFriendPickerViewController {
    
    func addSearchView() {
        let search = SWAddFriendView.view()
        self.view.addSubview(search)
        
        let height = SWAddFriendView.height()
        search.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(height)
        }
        search.addButton.addTarget(self, action: #selector(addFriendClick), for: .touchUpInside)
        self.searchView = search
    }
    
    func addTableView() {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(self.searchView.snp.bottom)
        }
        self.tableView = table
    }
    
    func addNavigationBarItem() {
        let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClick))
        navigationItem.rightBarButtonItems = [add]
    }
}

extension SWFriendPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SWFriendCell.defaultCell(for: tableView)
        let item = self.model.dataSource[indexPath.row]
        cell.setItem(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.model.selectItemAtIndex(indexPath.row)
    }    
}
