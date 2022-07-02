//
//  DBManager.swift
//  CoreDataExample
//
//  Created by Sun on 10/12/2021.
//

import UIKit
import CoreData

public protocol DBManagerType {
    var viewContext: NSManagedObjectContext { get }
    func save()
    func request(input: CoreDataBaseRequest) -> [CoreDataBaseRequest.T]
    func delete(object: NSManagedObject)
}

final public class DBManager {
    
    static public let shared: DBManagerType = DBManager()
    
    lazy public var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy public var viewContext = persistentContainer.viewContext
    
    public func save() {
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func delete(object: NSManagedObject) {
        viewContext.delete(object)
    }
}

extension DBManager: DBManagerType {
    
    public func request(input: CoreDataBaseRequest) -> [CoreDataBaseRequest.T] {
        let request = input.request
        if let dataArray = try? viewContext.fetch(request) {
            return dataArray
        } else {
            return [CoreDataBaseRequest.T]()
        }
    }
}
