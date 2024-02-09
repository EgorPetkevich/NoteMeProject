//
//  TimeNotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import CoreData


public final class TimeNotificationStorage:
    NotificationStorage<TimeNotificationDTO> {}
    
//    typealias ComplitionHandler = (Bool) -> Void
//    
//    public init() {}
//    
//    //fetch
//    public func fetch(predicate: NSPredicate? = nil,
//                      sortDescriptors: [NSSortDescriptor] = []
//    ) -> [TimeNotificationDTO] {
//        return fetchMO(predicate: predicate,
//                     sortDescriptors: sortDescriptors)
//        .compactMap { TimeNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(predicate: NSPredicate? = nil,
//                       sortDescriptors: [NSSortDescriptor] = [])
//    -> [TimeNotificatoinMO] {
//        let request: NSFetchRequest<TimeNotificatoinMO> = TimeNotificatoinMO.fetchRequest()
//        let context = CoreDataService.shared.context
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //create
//    func create(dto: TimeNotificationDTO,
//                complition: ComplitionHandler? = nil) {
//        let context = CoreDataService.shared.context
//        context.perform {
//            let mo = TimeNotificatoinMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(complition: complition)
//        }
//    }
//    
//    func update(dto: TimeNotificationDTO,
//                complition: ComplitionHandler? = nil) {
//        let context = CoreDataService.shared.context
//        
//        context.perform { [weak self] in
//            guard
//                let mo = self?.fetchMO(
//                    predicate: .Notification.noutification(byId: dto.id)
//                ).first
//            else { return }
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(complition: complition)
//        }
//    }
//  
//    func updateOrCreate(dto: TimeNotificationDTO,
//                        complition: ComplitionHandler? = nil) {
//
//        if fetchMO(predicate: .Notification.noutification(byId: dto.id)).isEmpty {
//            create(dto: dto, complition: complition)
//        } else {
//            update(dto: dto, complition: complition)
//        }
//    }
//    
//}
