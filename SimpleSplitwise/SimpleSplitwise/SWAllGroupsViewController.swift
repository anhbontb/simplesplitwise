//
//  ViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SWAllGroupsViewController: UITableViewController {
    
    let bag = DisposeBag()
    let model = SWAllGroupsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setupEvent()
        self.model.loadDataSource()
    }
    
    func setupEvent() {
        self.model.dataSourceSignal.subscribe(onNext: { [weak self](datas) in
            self?.tableView.reloadData()
        }).disposed(by: bag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addGroup = segue.destination as? SWAddGroupViewController else {
            return
        }
        setupCallBack(addGroup)
    }
    
    func setupCallBack(_ addGroup: SWAddGroupViewController) {
        addGroup.result.subscribe(onNext: { [weak self] (groupData) in
            self?.addGroup(groupData)
            self?.popMe()
        }).disposed(by: bag)
    }
    
    func addGroup(_ group: SWGroupData) {
        model.add(group: group)
    }
}


extension SWAllGroupsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        let group = model.dataSource[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = group.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detail = UIStoryboard.currentStoryboard()?.viewController("DetailViewController") as? SWGroupDetailViewController else {
            return
        }
        detail.setGroup(model.dataSource[indexPath.row])
        self.navigationController?.pushViewController(detail, animated: true)        
    }
    
}


