//
//  SqliteDbClient.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import SQLite

class SqliteDbClient {
    
    // MARK: - Properties
    
    let modelName: String
    let backgroundQueue = DispatchQueue.global(qos: .background)
    
    // MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Database structure
    
    private lazy var databasePath: String = {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(modelName).absoluteString
            return fileURL
        } catch (let error) {
            fatalError("Unable to Load Persistent Store - \(error)")
        }
    }()
}

// MARK: - DatabaseClient

extension SqliteDbClient: DatabaseClient {
    
    func createTableStructure() {
        do {
            let db = try Connection(databasePath)
            
            let ids = Table("GroupIds")
            let id = Expression<Int>("id")
            
            try db.run(ids.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
            })
        } catch (let error) {
            fatalError("Unable to create table - \(error)")
        }
    }
    
    func loadObjects<T: Decodable>(completion: @escaping ([T], Error?) -> Void) {
        backgroundQueue.async {
            do {
                let db = try Connection(self.databasePath)
                let tableName = String(describing: T.self)
                let table = Table(tableName)
                let records: [T] = try db.prepare(table).map({ row in
                    return try row.decode()
                })
                
                DispatchQueue.main.async {
                    return completion(records, nil)
                }
            } catch (let error) {
                print("Error occured - \(error) ")
                DispatchQueue.main.async {
                    return completion([], Error.unknownError)
                }
            }
        }
    }

    func insert<T: Encodable>(_ objects: [T], completion: @escaping (Error?) -> Void) {
        backgroundQueue.async {
            do {
                let db = try Connection(self.databasePath)
                let tableName = String(describing: T.self)
                let table = Table(tableName)
                
                for object in objects {
                    try db.run(table.insert(object))
                }
                
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch (let error) {
                print("Error occured - \(error) ")
                DispatchQueue.main.async {
                    completion(Error.unknownError)
                }
            }
        }
    }
}
