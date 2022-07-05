//
//  DBManager.swift
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

@objcMembers final public class DBManager {
    static public let shared: DBManagerType = DBManager()
    
    private func createManagedObjectModel() -> NSManagedObjectModel? {
         let libBundle = Bundle(identifier: "IOS.MobioSDKSwift")
        if let modelURL = libBundle?.url(forResource: "CoreData", withExtension: "momd") {
            return NSManagedObjectModel(contentsOf: modelURL)
        } else {
            return nil
        }
    }
    
    private func createPersistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        if let managedObjectModel = createManagedObjectModel() {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            return coordinator
        } else {
            return nil
        }
    }
    
    lazy public var viewContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let persistentStoreCoordinator = createPersistentStoreCoordinator()
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }()
    
    public func save() {
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
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
