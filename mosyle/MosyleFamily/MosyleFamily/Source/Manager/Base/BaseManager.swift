//
//  BaseManager.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 16/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

class BaseManager: OperationQueue {
    
    /**
     Initialize an BaseManager subclass.
     
     - parameter maxConcurrentOperationCount: maximun number of concurrent operations.
     
     - returns: an instance of BaseManager subclass.
     */
    convenience init(maxConcurrentOperationCount: Int) {
        self.init()
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    // MARK: Deinitalizers
    
    deinit {
        cancelAllOperations()
    }
}
