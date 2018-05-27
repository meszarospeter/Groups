//
//  LoadGroupsOperation.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

class LoadGroupsOperation: BaseServerOperation<[Group]> {
    
    init() {
        super.init(baseUrl: kBaseUrl)
    }
    
    class func run(completion: @escaping (_ result: [Group]) -> Void, failure: @escaping FailBlock) {
        let operation = LoadGroupsOperation()
        operation.run(completion, failure: failure)
    }
    
    override func serverOperationUrlSuffix() -> String? {
        return "/list.php?page=1&limit=30"
    }
    
    override func resultForData(_ data: Any) -> [Group]? {
        guard let dataResponse = data as? [String : Any], let response = dataResponse["list"] as? [[String : Any]] else {
            return nil
        }
        
        var groups: [Group] = []
        
        for responseData in response {
            if let groupResponse = GroupResponse(JSON: responseData) {
                if let group = groupResponse.getGroup() {
                    groups.append(group)
                }
            }
        }
        
        return groups
    }
}
