//
//  SWFriendPickerModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SWFriendPickerModel {
    
    fileprivate let db = SWDatabase()
    var dataSource = [SWFriendPickerData]()
    let dataSourceSignal = PublishSubject<[SWFriendPickerData]>()
        
    func loadDataSource() {
        
        let dbFriend: [SWFriend] = self.db.getAllData() ?? []
        let allFriend = dbFriend.map({ (oneFriend) -> SWFriendPickerData in
            return SWFriendPickerData(name: oneFriend.name ?? "")
        })
        
        self.dataSource = allFriend
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func addFriend(_ name: String?) {
        
        guard let name = name, !name.isEmpty else {
            return
        }
        db.add(data: SWFriend.init(name: name))
        dataSource.insert(SWFriendPickerData(name: name, selected: true), at: 0)
        
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func selectItemAtIndex(_ index: Int) {
        if index >= self.dataSource.count || index < 0  {
            return
        }
        let item = dataSource[index]
        dataSource[index].selected = !item.selected
        dataSourceSignal.onNext(self.dataSource)
    }
    
    func selectedFriend() -> [SWFriendPickerData] {        
        return dataSource.filter({ $0.selected})
    }
}
