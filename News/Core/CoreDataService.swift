//
//  CoreDataService.swift
//  News
//
//  Created by Тагир Булыков on 29.03.2024.
//

import CoreData

protocol CoreDataService {
    var context: NSManagedObjectContext { get }
    func saveContext()
    func fetch(nameDB: String, predicate: NSPredicate?) -> [NSManagedObject]
    func deleteContext(article: NSManagedObject)
}

class CoreDataServiceImpl: CoreDataService {
    static var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "CoreData")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    var context: NSManagedObjectContext {
        CoreDataServiceImpl.persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch(nameDB: String, predicate: NSPredicate? = nil) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: nameDB)
        fetchRequest.predicate = predicate
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteContext(article: NSManagedObject) {
        context.delete(article)
        saveContext()
    }
    
}

/// вычисляемые свойства
/// lazy, try - прочитать



