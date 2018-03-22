//
//  GroupManager.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 16/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

class GroupManager : BaseManager {
    
    /// Group Business
    private lazy var business: GroupBusiness = {
        return GroupBusiness()
    }()
    
    /// GroupOperaion manager
    ///
    /// - Parameters:
    ///   - completion: completion callback
    func fetchGroup(refresh: Bool = false,
                        _ completion: @escaping GroupObjectCallback) {
        addOperation {
            self.business.fetchGroup(completion: { (group) in
                OperationQueue.main.addOperation {
                    completion(group)
                }
            })
        }
    }
    
}
