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
    
    let db = SWFriendTable()
        
    func loadDataSource() -> Observable<[SWFriendPickerData]> {
        return Observable<[SWFriendPickerData]>.create { [weak self] (observer) -> Disposable in
            let dbFriend = self?.db.getAllFriend() ?? []
            let allFriend = dbFriend.map({ (oneFriend) -> SWFriendPickerData in
                 let friend = SWFriendPickerData()
                 friend.name = oneFriend.name ?? ""
                 return friend
            })
            
            observer.onNext(allFriend)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func addFriend(_ name: String) {
        let friend = SWFriend.init(name: name)
        self.db.add(friend: friend)
    }
}
