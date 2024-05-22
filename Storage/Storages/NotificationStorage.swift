//
//  NotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 7.02.24.
//

import Foundation
import CoreData

public class NotificationStorage<DTO: DTODescription> {
    
    public typealias ComplitionHandler = (Bool) -> Void
    
    public init() {}
    
    private func fetchMO(predicate: NSPredicate? = nil,
                         sortDescriptors: [NSSortDescriptor] = [],
                         context: NSManagedObjectContext)
    -> [DTO.MO] {
        let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [any DTODescription] {
        let context = CoreDataService.shared.mainContext
        return fetchMO(predicate: predicate,
                       sortDescriptors: sortDescriptors,
                       context: context)
        .compactMap { $0.toDTO() }
    }
    
    public func update(dto: any DTODescription,
                       complition: ComplitionHandler? = nil,
                       context: NSManagedObjectContext) {
        let context = CoreDataService.shared.backgroundContext
    
            context.perform { [weak self] in
                guard
                    let mo = self?.fetchMO(
                        predicate: .Notification.notification(byId: dto.id),
                        context: context
                    ).first
                else { return }
                mo.apply(dto: dto)
    
                CoreDataService.shared.saveContext(context: context,
                                                   complition: complition)
            }
        }
    
    public func create(dto: any DTODescription,
                       complition: ComplitionHandler? = nil,
                       context: NSManagedObjectContext) {
        context.perform {
            let _ = dto.createMO(context: context)
            CoreDataService.shared.saveContext(context: context,
                                               complition: complition)
        }
    }
    
    public func updateOrCreate(dto: any DTODescription,
                               complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        
        if fetchMO(predicate: .Notification.notification(byId: dto.id),
                   context: context ).isEmpty {
            create(dto: dto, complition: complition, context: context)
        } else {
            update(dto: dto, complition: complition, context: context)
        }
    }
    
    public func createDTOs(dtos:  [any DTODescription],
                           complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            _ = dtos.map {
                $0.createMO(context: context)
            }
            CoreDataService.shared.saveContext(context: context,
                                               complition: complition)
        }
    }
    
    public func udateDTOs(dtos: [any DTODescription],
                          complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        let ids = dtos.map { $0.id }
        
        context.perform { [weak self] in
            guard let mos = self?.fetchMO(predicate: .Notification.notifications(in: ids), 
                                          context: context) else { return }
            mos.forEach { model in
                guard let dto = dtos.first(where: { $0.id == model.identifier }) else { return }
                model.apply(dto: dto)
            }
            CoreDataService.shared.saveContext(context: context,
                                               complition: complition)
        }
    }
    
    public func delete(dto: any DTODescription,
                       complition: ComplitionHandler? = nil) {
          let context = CoreDataService.shared.mainContext
          context.perform { [weak self] in
              guard let mo = self?.fetchMO(
                  predicate: .Notification.notification(byId: dto.id),
                  context: context).first
              else { return }
              context.delete(mo)
              CoreDataService.shared.saveContext(context: context,
                                                 complition: complition)
          }
      }
    
    public func deleteAll(dtos: [any DTODescription],
                          complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        context.perform { [weak self] in
            let ids = dtos.map { $0.id }
            let mos = self?.fetchMO(predicate: .Notification
                                               .notifications(in: ids),
                                    context: context)
            mos?.forEach(context.delete)
            CoreDataService.shared.saveContext(context: context,
                                               complition: complition)
        }
    }
    
}
