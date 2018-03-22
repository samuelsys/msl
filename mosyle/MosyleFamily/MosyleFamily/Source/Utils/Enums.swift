//
//  Enums.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 21/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import Foundation

enum Errors: Error {
    case parse(String)
    case invalidValue
    case offlineMode
}
