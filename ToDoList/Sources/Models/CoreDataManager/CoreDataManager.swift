//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Michał Nowak on 07/07/2021.
//

import CoreData

class CoreDataManager {
    // MARK: -- Private variable's
    private var storeType: String!
    
    private var persistentContainerName: String!
    
    // MARK: -- Public variable's
    public lazy var persistentContainer: NSPersistentContainer! = {
        let persistentContainer = NSPersistentContainer(name: self.persistentContainerName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = storeType
        
        return persistentContainer
    }()
    
    public lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: -- Private function's
    private func loadPersistentStore() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Was unable to load store \(error!)")
            }
        }
    }
    
    // MARK: -- Public function's
    public func setup(persistentContainerName: String, storeType: StoreType, completion: (() -> Void)? = {}) {
        self.persistentContainerName = persistentContainerName
        self.storeType = storeType.string
        self.loadPersistentStore()
    }
}
