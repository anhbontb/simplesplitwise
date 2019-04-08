//
//  SWSelectMemberModel.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/8/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import RxSwift

class SWSelectMemberModel: SWFriendPickerModel {
    
    var multipleSelect = false

    override func loadDataSource() {
        self.dataSourceSignal.onNext(self.dataSource)
    }
    
    func set(allMember:[String],
             selectedMenber:[String],
             multipleSelect: Bool = false) {
        
            let all = Set<String>(allMember)
            let selected = Set<String>(selectedMenber)
            let remain = all.subtracting(selected)
        
            var selectFriends = selected.map { SWFriendPickerData(name: $0, selected: true)}
            let remainFriends = remain.map { SWFriendPickerData(name: $0, selected: false)}
            selectFriends.append(contentsOf: remainFriends)
        
            self.dataSource = selectFriends
            self.multipleSelect = multipleSelect
    }
    
    override func selectItemAtIndex(_ index: Int) {
        if index >= self.dataSource.count || index < 0  {
            return
        }
        if (multipleSelect == false) {
            for (i, element) in dataSource.enumerated() {
                if (index == i) {
                    continue
                }
                element.selected = false
            }
        }
        let item = dataSource[index]
        dataSource[index].selected = !item.selected
        dataSourceSignal.onNext(self.dataSource)
    }
}
