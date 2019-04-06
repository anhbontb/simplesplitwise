//
//  SWFriendCell.swift
//  SimpleSplitwise
//
//  Created by Bon Bon on 4/6/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import Foundation
import UIKit

class SWFriendCell: UITableViewCell {
    func setItem( _ friend: SWFriendPickerData) {
        self.textLabel?.text = friend.name
        self.accessoryType = friend.selected ? .checkmark : .none
    }
}
