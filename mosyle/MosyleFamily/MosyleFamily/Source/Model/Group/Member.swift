//
//  Member.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

struct Member: Codable {
    
    var memberName: String?
    var urlPhoto: String?
    var type: String?
    var countDevices: Int?
    
    enum CodingKeys: String, CodingKey {
        case memberName = "member_name"
        case urlPhoto = "url_photo"
        case type
        case countDevices = "count_devices"
    }
}
