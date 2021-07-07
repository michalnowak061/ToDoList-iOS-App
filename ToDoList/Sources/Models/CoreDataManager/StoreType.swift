//
//  StoreType.swift
//  ToDoList
//
//  Created by Michał Nowak on 07/07/2021.
//

import CoreData

enum StoreType: String {
    
    case sqlLite
    
    case memory
    
    public var string: String {
        switch self {
        case .sqlLite:
            return NSSQLiteStoreType
        case .memory:
            return NSInMemoryStoreType
        }
    }
}
