//
//  Priority.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit

enum Priority: Int {
    
    case low
    
    case medium
    
    case high
    
    public var color: UIColor {
        get {
            switch self {
            case .low:
                return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            case .medium:
                return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            case .high:
                return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
    }
}
