//
//  ModelDelegate.swift
//  ToDoList
//
//  Created by Michał Nowak on 07/07/2021.
//

import Foundation

protocol TasksDataManagerDelegate: AnyObject {
    
    func fetchTasksSuccess(model: TasksDataManager, success: Bool)
}
