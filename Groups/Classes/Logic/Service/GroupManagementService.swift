//
//  GroupManagementService.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

class GroupManagementService {

    // MARK: - Properties
    
    fileprivate var settingsStorage: DietCoreData = UserDefaultsManager.shared
    fileprivate lazy var databaseManager: DatabaseManager = DatabaseManager()
    
    var groups: [Group]?
    
    // MARK: - Init
    
    init() {
        populateDatabaseIfNeeded()
    }
    
    // MARK: - Groups
    
    func loadGroups(success: @escaping ([Group]) -> Void, failure: @escaping FailBlock) {
        if let groups = groups {
            success(groups)
        } else {
            LoadGroupsOperation.run(completion: { [weak self] (groups) in
                guard let `self` = self else { return }
                
                self.groups = groups
                success(groups)
            }, failure: { (error) in
                failure(error)
            })
        }
    }
    
    // MARK: - Populate database
    
    fileprivate func populateDatabaseIfNeeded() {
        if settingsStorage.shouldPopulateDatabase {
            databaseManager.populateDatabase(completion: { [weak self] (error) in
                if error == nil {
                    self?.settingsStorage.shouldPopulateDatabase = false
                }
            })
        }
    }
}
