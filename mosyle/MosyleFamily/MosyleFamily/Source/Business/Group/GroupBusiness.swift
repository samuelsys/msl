//
//  GroupBusiness.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

typealias GroupObjectCallback = (@escaping () throws -> Group?) -> Void

class GroupBusiness {
    
    private var provider: GroupApiProvider
    
    init() {
        provider = GroupApiProvider()
    }
    
    func fetchGroup(completion: @escaping GroupObjectCallback) {
        
        provider.fetchGroup { (result) in
            
            guard let data = result,
                let group = try? JSONDecoder().decode(Group.self, from: data) else {
                    completion {
                        throw Errors.invalidValue
                    }
                    return
            }
            
            completion {
                group
            }
            return
        }
    }
}
