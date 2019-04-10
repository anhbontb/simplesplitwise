//
//  SWAddGroupViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit
import RxSwift

class SWAddGroupViewController: SWBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtGroupDescription: UITextField!
    @IBOutlet weak var txtGroupName: UITextField!
    var members: [String]?
    
    let bag = DisposeBag()
    let result = PublishSubject<SWGroupData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createGroupClick(_ sender: Any) {
        let name = self.txtGroupName.text ?? ""
        let description = self.txtGroupDescription.text ?? ""
        let menbers = self.members
        
        let group = SWGroupData.init(name: name, description: description, members: menbers)
        if validate(group: group) == false {
            return
        }
        self.result.onNext(group)
        self.result.onCompleted()
    }
    
    @IBAction func addMemberClick(_ sender: Any) {
        let view = SWFriendPickerViewController()
        self.navigationController?.pushViewController(view, animated: true)
        view.result.subscribe(onNext: { [weak self] (friends) in
            self?.members = friends.map({$0.name})
            self?.tableView.reloadData()
            self?.popMe()
        }).disposed(by: self.bag)
    }
    
    func validate(group: SWGroupData) -> Bool{
        guard let name = group.name, !name.isEmpty else {
            self.alert("Please input group name")
            return false
        }
        guard let member = group.members, !member.isEmpty else {
            self.alert("Please add group members")
            return false
        }
        guard member.count > 1 else {
            self.alert("Group should have more than one member")
            return false
        }
        return true
    }
}

extension SWAddGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.members?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.defaultCell(for: tableView)
        cell.textLabel?.text = self.members?[indexPath.row]
        return cell
    }
}
