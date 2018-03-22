//
//  GroupApiProtocol.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

typealias  GroupCallback = (Data?) -> Void

protocol GroupApiProtocol {
    
    // Fetch a group with a list of members
    func fetchGroup(completion: @escaping GroupCallback)
    
}
