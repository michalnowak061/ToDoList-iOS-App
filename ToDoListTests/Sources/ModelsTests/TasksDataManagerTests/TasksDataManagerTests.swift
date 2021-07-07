//
//  TasksDataManagerTests.swift
//  ToDoListTests
//
//  Created by Michał Nowak on 07/07/2021.
//

import XCTest
import CoreData
@testable import ToDoList

class TasksDataManagerTests: XCTestCase {
    private var sut: TasksDataManager!
    
    private var mock: TasksDataManagerDelegateMock!
    
    override func setUp() {
        super.setUp()
        self.mock = TasksDataManagerDelegateMock()
        self.sut = TasksDataManager(storeType: .memory)
        self.sut.delegate = mock
    }
    
    override func tearDown() {
        self.mock = nil
        self.sut = nil
        super.tearDown()
    }
    
    // MARK: -- Test's
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchTasks() {
        let count = mock.fetchTasksSuccessCallCount
        self.sut.fetchTasks()
        XCTAssertEqual(mock.fetchTasksSuccessCallCount, count + 1)
    }
    
    func testSaveTasks() {
        self.sut.saveTasks()
    }
    
    func testCreateTask() {
        let count = sut.count
        self.sut.createTask(self.createTestTask())
        self.sut.saveTasks()
        self.sut.fetchTasks()
        XCTAssertEqual(sut.count, count + 1)
    }
    
    func testDeleteTask() {
        self.sut.createTask(self.createTestTask())
        self.sut.saveTasks()
        self.sut.fetchTasks()
        
        let count = sut.count
        self.sut.deleteTask(atIndex: 0)
        self.sut.saveTasks()
        self.sut.fetchTasks()
        XCTAssertEqual(sut.count, count - 1)
    }
    
    func testDeleteFail() {
        self.sut.deleteTask(atIndex: 0)
        self.sut.saveTasks()
        self.sut.fetchTasks()
        XCTAssertEqual(sut.count, 0)
    }
    
    func testUpdateTask() {
        self.sut.createTask(self.createTestTask())
        self.sut.saveTasks()
        self.sut.fetchTasks()
        
        let oldName = sut.getTask(atIndex: 0)?.name ?? "nil"
        var task = createTestTask()
        task.name = "New task name"
        
        self.sut.updateTask(task: task, atIndex: 0)
        XCTAssertEqual(oldName, "Test task")
        XCTAssertEqual(sut.getTask(atIndex: 0)?.name, "New task name")
    }
    
    func testGetTask() {
        self.sut.createTask(self.createTestTask())
        self.sut.saveTasks()
        self.sut.fetchTasks()
        XCTAssertNotNil(sut.getTask(atIndex: 0))
    }
    
    func testGetTaskFail() {
        XCTAssertNil(sut.getTask(atIndex: 0))
    }
    
    // MARK: -- Private function's
    private func createTestTask() -> Task {
        Task(isDone: false, name: "Test task", priority: 0)
    }
    
    private func createDoneTestTask() -> Task {
        Task(isDone: true, name: "Test task", priority: 0)
    }
}
