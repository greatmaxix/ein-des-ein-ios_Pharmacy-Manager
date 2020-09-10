//
//  CoreDataService.swift
//  KyivPost
//
//  Created by Anton Bal’ on 01.08.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import CoreData


enum CoreDataError: Error, LocalizedError {
    case saveInteraption(Error)
}

class CoreDataService {
    
    enum CoraData {
        static let name = "KyivPost"
    }
    
    static let shared = CoreDataService()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        let container = NSPersistentContainer(name: CoraData.name)
        container.persistentStoreDescriptions.append(description)
        return container
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.parent = mainContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    var context: NSManagedObjectContext {
        if Thread.isMainThread {
            return mainContext
        } else {
            return backgroundContext
        }
    }
    
    func setup(completion: (() -> Void)? = nil) {
        loadPersistentStore(completion: completion)
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: (() -> Void)?) {
        self.persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
            
            completion?()
        }
    }
    
    func save() throws {
        if Thread.isMainThread, persistentContainer.viewContext.hasChanges {
            try persistentContainer.viewContext.save()
        } else if !Thread.isMainThread,
            backgroundContext.hasChanges {
            try backgroundContext.save()
            try backgroundContext.parent?.save()
        }
    }
}

extension CoreDataService {
    func delete<T: CoreDataPersistable>(_ persistable: T) throws  {
        let request = persistable.predictableFetchRequest
        guard let object = try context.fetch(request).first as? T.ManagedObject else { return }
        context.delete(object)
        try save()
    }
    
    func save<T: CoreDataPersistable & CoreDataRepresentable>(_ persistable: T) throws  {
        let request = persistable.predictableFetchRequest
        let result = try context.fetch(request)
        let object: T.ManagedObject = (result.first as? T.ManagedObject) ?? T.ManagedObject(context: context)
        try persistable.update(object, context: context)
        try save()
    }
    
    func get<T: CoreDataRepresentable>(by id: T.ID) throws -> T? {
        let request = T.ManagedObject.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        guard let object = try context.fetch(request).first as? T.ManagedObject else { return nil }
        return try T(object, context: context)
    }
    
    func fetchFirst<T: CoreDataRepresentable>() throws -> T?{
        let request = T.ManagedObject.fetchRequest()
        guard let object = try context.fetch(request).first as? T.ManagedObject else { return nil }
        return try T(object, context: context)
    }
    
    func fetchCollection<T: CoreDataRepresentable>() throws -> [T] {
        let request = T.ManagedObject.fetchRequest()
        return try context.fetch(request)
            .compactMap { $0 as? T.ManagedObject }
            .map {  try T($0, context: context) }
    }
}
