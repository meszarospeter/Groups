//
//  UserDefaultsManager.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Foundation

fileprivate protocol UserDefaultsKey {
    func key() -> String
}

private enum Key: UserDefaultsKey {
    case populateDatabase
    
    func key() -> String {
        switch self {
            case .populateDatabase:
                return "meszarospeter.Groups.userdefkey.shouldPopulateDatabase"
        }
    }
}

// MARK: -

protocol DietCoreData {
    var shouldPopulateDatabase: Bool { get set }
}

// MARK: -

class UserDefaultsManager: DietCoreData {
    
    // MARK: - Properties

    fileprivate let userDefaults = UserDefaults.standard

    // MARK: - Lifecycle
    
    static let shared = UserDefaultsManager()
    
    init() {
        registerDefaults()
    }
    
    // MARK: - Defaults
    
    fileprivate func registerDefaults() {
        let defaults: [String: Any] = [Key.populateDatabase.key(): true]
        userDefaults.register(defaults: defaults)
    }
    
    // MARK: keychain
    
    var shouldPopulateDatabase: Bool {
        get { return userDefaults.bool(forKey: Key.populateDatabase.key()) }
        set { userDefaults.set(newValue, forKey: Key.populateDatabase.key()) }
    }
}
