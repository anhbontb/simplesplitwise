//
//  SWGroupDetailViewController.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import UIKit

class SWGroupDetailViewController: SWBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbMember: UILabel!

    var group: SWGroupData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.showGroupInfo()
    }
    
    func showGroupInfo() {
        self.lbName.text = group.name
        self.lbDescription.text = group.description
        self.lbMember.text = group.members?.joined(separator: ",")
    }    
}

extension SWGroupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }    
}
