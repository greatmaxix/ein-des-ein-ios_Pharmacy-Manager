//
//  DataBasePersistable.swift
//  KyivPost
//
//  Created by Anton Bal’ on 01.08.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import CoreData

protocol DataBasePersistable: Identifiable {
    associatedtype ManagedObject
    associatedtype Context
    func update(_ object: ManagedObject, context: Context) throws
}

extension DataBasePersistable where Context == Void {
    func update(_ object: ManagedObject) throws {
        try update(object, context: ())
    }
}

protocol DataBasePersistableCollection {
    associatedtype Item: DataBasePersistable
    var items: [Item] { get }
}

extension Array: DataBasePersistableCollection where Element: DataBasePersistable {
    typealias Item = Element
    var items: [Item] { return self }
}


protocol CoreDataPersistable: CoreDataPredicatableRequest, DataBasePersistable where Context == NSManagedObjectContext{
}
