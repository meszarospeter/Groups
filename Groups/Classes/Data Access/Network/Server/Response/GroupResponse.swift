//
//  GroupsResponse.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupResponse: Mappable {

    var id: Int?
    var title: String = ""
    var thumbnailUrl: String = ""
    
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["name"]
        thumbnailUrl <- map["image"]
    }
}

extension GroupResponse {
    
    func getGroup() -> Group? {
        guard let id = id else { return nil }
        
        let group = Group()
        group.id = id
        group.title = title
        group.thumbnailUrl = thumbnailUrl
        
        return group
    }
}
