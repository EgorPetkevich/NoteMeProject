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
                       sortDescriptors: [NSSortDescriptor] = [])
    -> [DTO.MO] {
        let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let context = CoreDataService.shared.mainContext
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [any DTODescription] {
        return fetchMO(predicate: predicate,
                     sortDescriptors: sortDescriptors)
        .compactMap { $0.toDTO() }
    }
    
    func update(dto:  DTO,
                complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
    
            context.perform { [weak self] in
                guard
                    let mo = self?.fetchMO(
                        predicate: .Notification.noutification(byId: dto.id)
                    ).first
                else { return }
                mo.apply(dto: dto)
    
                CoreDataService.shared.saveContext(context: context,
                                                   complition: complition)
            }
        }
    
    public func create(dto: DTO,
                       complition: ComplitionHandler? = nil) {
        let context = CoreDataService.shared.backgroundContext
        
        context.perform {
            let mo = DTO.MO(context: context)
            mo.apply(dto: dto)
            CoreDataService.shared.saveContext(context: context,
                                               complition: complition)
        }
    }
    
    public func updateOrCreate(dto: DTO,
                        complition: ComplitionHandler? = nil) {
        if fetchMO(predicate: .Notification.noutification(byId:
                                                            dto.id)).isEmpty {
            create(dto: dto, complition: complition)
        } else {
            update(dto: dto, complition: complition)
        }
    }
    
    public func delete(dto: any DTODescription,
                       complition: ComplitionHandler? = nil) {
          let context = CoreDataService.shared.mainContext
          context.perform { [weak self] in
              guard let mo = self?.fetchMO(
                  predicate: .Notification.noutification(byId:
                                                            dto.id)).first
              else { return }
              context.delete(mo)
              CoreDataService.shared.saveContext(context: context,
                                                 complition: complition)
          }
      }
    
}

