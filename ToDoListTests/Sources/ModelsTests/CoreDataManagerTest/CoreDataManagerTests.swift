//
//  CoreDataManagerTests.swift
//  ToDoListTests
//
//  Created by Michał Nowak on 07/07/2021.
//

import XCTest
import CoreData
@testable import ToDoList

class CoreDataManagerTests: XCTestCase {
    private var sut: CoreDataManager!
    
    private let persistentContainerName = "ToDoListDataModel"
    
    override func setUp() {
        super.setUp()
        sut = CoreDataManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: -- Test's
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func testPersistentContainerName() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
        XCTAssertEqual(sut.persistentContainer.name, self.persistentContainerName)
    }
    
    func testBackgroundContext() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
        XCTAssertNotNil(sut.backgroundContext)
    }
    
    func testMainContext() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
        XCTAssertNotNil(sut.mainContext)
    }
    
    func testPersistentStoreCreate() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
        XCTAssertTrue(self.sut.persistentContainer.persistentStoreCoordinator.persistentStores.count > 0)
    }
    
    func testSetupWithMemoryStoreType() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
        XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSInMemoryStoreType)
    }
    
    func testSetupWithSqlLiteStoreType() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .sqlLite)
        XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSSQLiteStoreType)
    }
    
    func testSetupCompletionCalled() {
        sut.setup(persistentContainerName: self.persistentContainerName, storeType: .memory)
    }
}
