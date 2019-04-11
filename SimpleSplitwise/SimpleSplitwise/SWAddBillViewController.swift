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
    let result = PublishSubject<SWBillData>()
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
        
        self.txtDescription
            .rx
            .text
            .changed
            .subscribe(onNext: { [weak self](text) in
                self?.model.updateBillDescription(text ?? "")
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
    
    @IBAction func createBillClick(_ sender: Any) {
        let bill = self.model.getBill()
        if self.validate(bill: bill) == false {
            return
        }
        self.result.onNext(bill)
        self.result.onCompleted()
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
    
    func validate(bill : SWBillData) -> Bool {
        
        guard let paider = bill.paider, !paider.isEmpty else {
            alert("Please select paider")
            return false
        }
        
        if bill.members.isEmpty || bill.amountDetail.count <= 1 {
            alert("Please select member")
            return false
        }
        
        if bill.amount <= 0 {
            alert("Please input bill amount")
            return false
        }        
        
        return true
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
        setup(cell: cell, data: info, index: indexPath.row)
        return cell
    }
    
    func setup(cell: SWBillValueCell, data info: SWBillValueData, index: Int) {
        cell.lbName.text = info.name
        info.value
            .asObserver()
            .distinctUntilChanged()
            .filter({ (_) -> Bool in return !cell.txtValue.isEditing})
            .map({ (value) -> String in
                return value <= 0 ? "0" : String(value)
            })
            .bind(to: cell.txtValue.rx.text)
            .disposed(by: bag)
        
        weak var weakCell = cell
        cell.txtValue
            .rx
            .text
            .changed
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .debug()
            .subscribe(onNext: { [weak self] (text) in
                let amount = Float(self?.txtAmount.text ?? "") ?? 0
                let input = Float(text ?? "") ?? 0
                if (input > amount) {
                    self?.alert("Input value is greater than total amount")
                    weakCell?.txtValue.text = "0"
                    return
                }
                self?.model.update(amount: text ?? "", index: index)
            }).disposed(by: bag)
    }
}
