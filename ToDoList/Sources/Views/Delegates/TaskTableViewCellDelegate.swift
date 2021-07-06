//
//  TaskTableViewCellDelegate.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import Foundation

protocol TaskTableViewCellDelegate: AnyObject {
    
    func didSelect(taskTableViewCell: TaskTableViewCell, didSelect: Bool)
    
    func didDeselect(taskTableViewCell: TaskTableViewCell, didDeselect: Bool)
}
