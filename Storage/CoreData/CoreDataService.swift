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
        let context =  persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    private var persistentContainer: NSPersistentContainer = {
        let modelName = "NotificationDataBase"
        let bundle = Bundle(for: CoreDataService.self)
        guard
            let modelURL = bundle.url(forResource: modelName,
                                      withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else { fatalError("unable to find model in bundle") }
            
        let container = NSPersistentContainer(name: modelName,
                                                  managedObjectModel: managedObjectModel)
            
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
//        if context.hasChanges {
            do {
                try context.save()
                complition?(true)
            } catch {
                let nserror = error as NSError
                complition?(false)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
//        }
    }
    
}
