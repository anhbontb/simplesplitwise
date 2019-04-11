//
//  SWBillDetailHistory.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/11/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

class SWBillDetailHistoryViewController: SWAddBillViewController {
    class func detailView(bill: SWBillData) -> SWAddBillViewController? {
        guard let detail = UIStoryboard.currentStoryboard()?.viewController("SWBillDetailHistory") as? SWAddBillViewController else {
            return nil
        }
        let model = SWBillDetailHistory()
        model.setBill(bill)
        detail.model = model
        return detail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.model.buildDataSource()
    }
    
    func setupView() {
        self.txtAmount.isUserInteractionEnabled = false
        self.txtDescription.isUserInteractionEnabled = false
        self.btnDate.isUserInteractionEnabled = false
        self.btnPaider.isUserInteractionEnabled = false
        self.btnMembers.isHidden = true
        
        let bill = self.model.billData
        let paider = bill.paider ?? ""
        
        showDate(bill.createDate)
        self.btnPaider.setTitle(paider, for: .normal)
        self.txtAmount.text = String(bill.amount)
        self.txtDescription.text = bill.billDescription
    }
    
    override func setup(cell: SWBillValueCell, data info: SWBillValueData, index: Int) {
        cell.lbName.text = info.name
        cell.txtValue.text = String(try! info.value.value())
        cell.txtValue.isUserInteractionEnabled = false
    }
}
