//
//  NotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 7.02.24.
//

import Foundation
import CoreData

public class NotificationStorage<DTO: DTODescription> {
    
    typealias ComplitionHandler = (Bool) -> Void
    
    public init() {}
    
    private func fetchMO(predicate: NSPredicate? = nil,
                       sortDescriptors: [NSSortDescriptor] = [])
    -> [DTO.MO] {
        let request = NSFetchRequest<DTO.MO>(entityName: "\(DTO.MO.self)")
        let context = CoreDataService.shared.backgroundContext
        let results = try? context.fetch(request)
        return results ?? []
    }
    
    public func fetch(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor] = []
    ) -> [DTO] {
        return fetchMO(predicate: predicate,
                     sortDescriptors: sortDescriptors)
        .compactMap { DTO(mo: $0) }
    }
    
    func update(dto: any DTODescription,
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
    
        func create(dto: any DTODescription,
                    complition: ComplitionHandler? = nil) {
            let context = CoreDataService.shared.backgroundContext
            context.perform {
                let mo = DTO.MO(context: context)
                mo.apply(dto: dto)
    
                CoreDataService.shared.saveContext(context: context,
                                                   complition: complition)
            }
        }
    
        func updateOrCreate(dto: any DTODescription,
                            complition: ComplitionHandler? = nil) {
    
            if fetchMO(predicate: .Notification.noutification(byId: dto.id)).isEmpty {
                create(dto: dto, complition: complition)
            } else {
                update(dto: dto, complition: complition)
            }
        }
}

