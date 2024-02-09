//
//  LocationNotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 6.02.24.
//

import CoreData

public final class LocationNotificationStorage:
    NotificationStorage<LocationNotificationDTO> {}
//
//    typealias ComplitionHandler = (Bool) -> Void
//    
//    public init() {}
//    
//    //fetch
//    public func fetch(predicate: NSPredicate? = nil,
//                      sortDescriptors: [NSSortDescriptor] = []
//    ) -> [LocationNotificationDTO] {
//        return fetchMO(predicate: predicate,
//                     sortDescriptors: sortDescriptors)
//        .compactMap { LocationNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(predicate: NSPredicate? = nil,
//                       sortDescriptors: [NSSortDescriptor] = [])
//    -> [LocationNotificationMO] {
//        let request: NSFetchRequest<LocationNotificationMO> = LocationNotificationMO.fetchRequest()
//        let context = CoreDataService.shared.context
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //create
//    func create(dto: LocationNotificationDTO,
//                complition: ComplitionHandler? = nil) {
//        let context = CoreDataService.shared.context
//        context.perform {
//            let mo = LocationNotificationMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(complition: complition)
//        }
//    }
//    
//    func update(dto: LocationNotificationDTO,
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
//    func updateOrCreate(dto: LocationNotificationDTO,
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
