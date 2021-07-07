//
//  TaskDataManagerDelegateMock.swift
//  ToDoListTests
//
//  Created by Michał Nowak on 07/07/2021.
//

import Foundation
@testable import ToDoList

class TasksDataManagerDelegateMock: TasksDataManagerDelegate {
    public var fetchTasksSuccessCallCount: Int = 0
    
    func fetchTasksSuccess(model: TasksDataManager, success: Bool) {
        self.fetchTasksSuccessCallCount += 1
    }
}
