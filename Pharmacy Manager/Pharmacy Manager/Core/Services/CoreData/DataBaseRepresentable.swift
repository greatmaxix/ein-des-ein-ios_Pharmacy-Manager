//
//  DataBaseRepresentable.swift
//  KyivPost
//
//  Created by Anton Bal’ on 01.08.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import CoreData

protocol DataBaseRepresentable: Identifiable {
    associatedtype ManagedObject
    associatedtype Context

    init(_ object: ManagedObject, context: Context) throws
}

protocol CoreDataRepresentable: DataBaseRepresentable, CoreDataPredicatableRequest where Context == NSManagedObjectContext {
    init(_ object: ManagedObject) throws
}

extension CoreDataRepresentable where ManagedObject: NSManagedObject {
    init(_ object: ManagedObject, context: Context) throws {
        try self.init(object)
    }
}
