//
//  CoreDataService.swift
//  Storage
//
//  Created by George Popkich on 30.01.24.
//

import CoreData

final class CoreDataService {
    
    typealias ComplitionHandler = (Bool) -> Void
    
    static var shared: CoreDataService = .init()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.parent = mainContext
        return context
    }
    

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotificationDataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveMainContext(complition: ComplitionHandler? = nil) {
        saveContext(context: mainContext, complition: complition)
    }
    
    func saveContext(context: NSManagedObjectContext,
                     complition: ComplitionHandler? = nil) {
        if context.hasChanges {
            do {
                try context.save()
                complition?(true)
            } catch {
                let nserror = error as NSError
                complition?(false)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
