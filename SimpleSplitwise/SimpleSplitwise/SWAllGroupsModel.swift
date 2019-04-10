//
//  SWAllGroupsModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/7/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class SWAllGroupsModel {
    var dataSource = [SWGroupData]()
    let dataSourceSignal = PublishSubject<[SWGroupData]>()
    let db = SWDatabase()

    deinit {
        self.dataSourceSignal.onCompleted()
    }
    
    func loadDataSource() {
        let groups: [SWGroupInfo] = db.getAllData() ?? []
        let dataSource = groups.map { (groupInfo) -> SWGroupData in
            let group = SWGroupData()
            group.groupId = groupInfo.groupId
            group.name = groupInfo.groupName
            group.description = groupInfo.groupDescription
            group.members = groupInfo.groupMembers.compactMap({$0})
            return group
        }
        self.dataSource = dataSource
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func add(group: SWGroupData) {
        
        let groupInfo = SWGroupInfo()
        groupInfo.groupId = Int64(Date().timeIntervalSince1970)
        groupInfo.groupName = group.name
        groupInfo.groupDescription = group.description
        if let members = group.members?.toList() {
            groupInfo.groupMembers = members
        }
        
        
        self.db.add(data: groupInfo)
        self.dataSource.insert(group, at: 0)
        self.dataSourceSignal.onNext(self.dataSource)
    }    
}
