//
//  DataBasePredicatableRequest.swift
//  KyivPost
//
//  Created by Anton Bal’ on 01.08.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import CoreData

protocol DataBasePredicatableRequest: Identifiable {
    
}

protocol CoreDataPredicatableRequest: DataBasePredicatableRequest {
    associatedtype ManagedObject: NSManagedObject
    var predictableFetchRequest: NSFetchRequest<NSFetchRequestResult> { get }
}

extension CoreDataPredicatableRequest where ManagedObject: NSManagedObject {
    var predictableFetchRequest: NSFetchRequest<NSFetchRequestResult> {
        let request = ManagedObject.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        return request
    }
}
