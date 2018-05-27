//
//  GroupsDetailViewModel.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GroupDetailViewModel {
    
    // MARK: - Properties

    let group = BehaviorRelay<Group?>(value: nil)
}
