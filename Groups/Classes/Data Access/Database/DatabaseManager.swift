//
//  DatabaseManager.swift
//  Todo
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Foundation

protocol DatabaseClient {
    func loadObjects<T: Decodable>(completion: @escaping ([T], Error?) -> Void)
    func insert<T: Encodable>(_ objects: [T], completion: @escaping (Error?) -> Void)
    func createTableStructure()
}

class DatabaseManager {

    // MARK: - Properties
    
    fileprivate var client: SqliteDbClient
    
    // MARK: - Initialization
    
    init() {
        client = SqliteDbClient(modelName: kDatabaseName)
    }
    
    // MARK: - General DB object handling
    
    fileprivate func save<T: Encodable>(objects: [T], completion: @escaping (Error?) -> Void) {
        client.insert(objects, completion: completion)
    }
    
    fileprivate func loadAllObject<T: Decodable>(completion: @escaping ([T], Error?) -> Void) {
        return client.loadObjects(completion: completion)
    }
    
    fileprivate func populateDatabaseStructure() {
        client.createTableStructure()
    }
}

// MARK: - Group Ids

extension DatabaseManager {
    
    func loadAllGroupIds(completion: @escaping ([Int], Error?) -> Void) {
        return loadAllObject(completion: completion)
    }
    
    func populateDatabase(completion: @escaping (Error?) -> Void) {
        populateDatabaseStructure()
    }
}
