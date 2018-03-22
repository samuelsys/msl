//
//  Group.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    var status: String?
    var groupName: String?
    var members: [Member]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case groupName = "group_name"
        case members
    }
}
