//
//  TasksDataManager.swift
//  ToDoList
//
//  Created by Michał Nowak on 07/07/2021.
//

import CoreData

class TasksDataManager {
    // MARK: -- Private variable's
    private var coreDataManager: CoreDataManager!
    
    private var context: NSManagedObjectContext {
        get {
            self.coreDataManager.backgroundContext
        }
    }
    
    private var taskEntities: [TaskEntity] = []
    
    private var doneTaskEntities: [TaskEntity] {
        get {
            self.taskEntities.filter { taskEntity in
                taskEntity.isDone
            }
        }
    }
    
    // MARK: -- Public variable's
    public weak var delegate: TasksDataManagerDelegate?
    
    public var count: Int {
        get {
            self.taskEntities.count
        }
    }
    
    public var doneCount: Int {
        get {
            self.doneTaskEntities.count
        }
    }
    
    // MARK: -- Public function's
    init(coreDataManager: CoreDataManager = CoreDataManager(), storeType: StoreType = .sqlLite, persistentContainerName: String = "ToDoListDataModel") {
        self.coreDataManager = coreDataManager
        self.coreDataManager.setup(persistentContainerName: persistentContainerName, storeType: storeType)
    }
    
    public func fetchTasks() {
        do {
            self.taskEntities = try self.context.fetch(TaskEntity.fetchRequest())
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }
    
    public func saveTasks() {
        do {
            try self.context.save()
        }
        catch {
            fatalError()
        }
    }
    
    public func createTask(_ task: Task) {
        let newTaskEntity = TaskEntity(context: self.context)
        newTaskEntity.isDone = task.isDone
        newTaskEntity.name = task.name
        newTaskEntity.priority = task.priority
    }
    
    public func deleteTask(atIndex index: Int) {
        guard index >= 0, index < self.count, self.count > 0 else {
            return
        }
        
        let entity = self.taskEntities[index]
        self.context.delete(entity)
    }
    
    public func updateTask(task: Task, atIndex index: Int) {
        guard index >= 0, index < self.count else {
            return
        }
        
        let entity = self.taskEntities[index]
        entity.isDone = task.isDone
        entity.name = task.name
        entity.priority = task.priority
    }
    
    public func getTask(atIndex index: Int) -> Task? {
        guard index >= 0, index < self.count else {
            return nil
        }
        
        let entity = self.taskEntities[index]
        let task = Task(isDone: entity.isDone,
                        name: entity.name ?? "empty name",
                        priority: entity.priority)
        
        return task
    }
    
    public func removeAllDoneTasks() {
        var index: Int = 0
        for entity in self.taskEntities {
            if entity.isDone {
                self.deleteTask(atIndex: index)
            }
            index += 1
        }
    }
}
