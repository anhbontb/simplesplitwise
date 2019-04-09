//
//  SWAddBillViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/8/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SWAddBillViewController: SWBaseViewController {
    
    var bag = DisposeBag()
    let result = PublishSubject<SWGroupData>()
    var model = SWAddBillModel()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var btnMembers: UIButton!
    @IBOutlet weak var btnPaider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDatePicker()
        self.setupEvent()
    }
    
    func setupEvent() {
        self.model.dataSourceSignal.subscribe(onNext: { [weak self](data) in
            self?.tableview.reloadData()
        }).disposed(by: self.bag)

        self.txtAmount
            .rx
            .text
            .changed
            .distinctUntilChanged()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self](text) in
                self?.model.updateAmount(text ?? "")
            }).disposed(by: bag)
    }
    
    func setGroup(_ group: SWGroupData) {
        self.model.group = group
    }
    
    
    func setupDatePicker () {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        self.txtDate.inputView = datePicker
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDone));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(datePickerCancel));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        self.txtDate.inputAccessoryView = toolbar
    }
    
    @IBAction func datePickerCancel() {
        self.txtDate.resignFirstResponder()
    }
    
    @IBAction func datePickerDone() {
        guard let datePicker = self.txtDate.inputView as? UIDatePicker else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: datePicker.date)
        self.btnDate.setTitle(date, for: .normal)
        self.txtDate.resignFirstResponder()
    }
    
    @IBAction func chooseDateClick(_ sender: Any) {
        self.txtDate.becomeFirstResponder()
    }
    
    @IBAction func choosePaiderClick(_ sender: Any) {
        let dataSource = self.model.paiderDataSource()
        SWSelectMemberPicker.showPick(from: self,
                                      allmembers: dataSource,
                                      selectedMenber: [], multipleSelect: false)
                            .subscribe(onNext: {[weak self] (friends) in
                                if let friend = friends.first {
                                    self?.btnPaider.setTitle(friend.name, for: .normal)
                                    self?.model.selectPaider(friend)
                                }
                                self?.popMe()
                            }).disposed(by: bag)
    }
    
    @IBAction func addMemberClick(_ sender: Any) {
        let members = self.model.memberDataSource()
        SWSelectMemberPicker.showPick(from: self,
                                      allmembers: members,
                                      selectedMenber: [], multipleSelect: true)
                            .subscribe(onNext: {[weak self] (friends) in
                                self?.model.selectMember(friends)
                                self?.popMe()
                            }).disposed(by: bag)

    }
}

extension SWAddBillViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SWBillValueCell.defaultCell(for: tableView)
        let index = indexPath.row
        let info = model.dataSource[index]
        cell.lbName.text = info.name
        
        info.value
            .asObserver()
            .distinctUntilChanged()
            .map({String($0)})
            .bind(to: cell.txtValue.rx.text)
            .disposed(by: bag)
        
        
        cell.txtValue
            .rx
            .text
            .changed
            .distinctUntilChanged()
            .throttle(0.8, scheduler: MainScheduler.instance)
            .debug()
            .subscribe(onNext: {[weak self](text) in
                self?.model.update(amount: text ?? "", index: index)
            })
            .disposed(by: bag)
        return cell
    }    
}
