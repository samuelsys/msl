//
//  GroupApiProvider.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 15/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation
import Alamofire

class GroupApiProvider : GroupApiProtocol {
    func fetchGroup(completion: @escaping GroupCallback) {
        Alamofire.request("https://mosyle.com/json_template.php").responseJSON { (response) in
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion (data)
            
        }
    }
}
