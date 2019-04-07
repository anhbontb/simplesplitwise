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
    var dataSource = [SWGroupData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        self.dataSource.insert(group, at: 0)
        self.tableView.reloadData()
    }
}


extension SWAllGroupsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        let group = self.dataSource[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = group.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

