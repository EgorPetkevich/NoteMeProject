//
//  DateNotificationStorage.swift
//  Storage
//
//  Created by George Popkich on 30.01.24.
//

import CoreData

public final class DateNotificationStorage: 
    NotificationStorage<DateNotificationDTO> {}


//    typealias ComplitionHandler = (Bool) -> Void
//    
//    public init() {}
//    
//    //fetch
//    public func fetch(predicate: NSPredicate? = nil,
//                      sortDescriptors: [NSSortDescriptor] = []
//    ) -> [DateNotificationDTO] {
//        return fetchMO(predicate: predicate,
//                     sortDescriptors: sortDescriptors)
//        .compactMap { DateNotificationDTO(mo: $0) }
//    }
//    
//    private func fetchMO(predicate: NSPredicate? = nil,
//                       sortDescriptors: [NSSortDescriptor] = [])
//    -> [DateNotificationMO] {
//        let request: NSFetchRequest<DateNotificationMO> = DateNotificationMO.fetchRequest()
//        let context = CoreDataService.shared.context
//        let results = try? context.fetch(request)
//        return results ?? []
//    }
//    
//    //create
//    func create(dto: DateNotificationDTO,
//                complition: ComplitionHandler? = nil) {
//        let context = CoreDataService.shared.context
//        context.perform {
//            let mo = DateNotificationMO(context: context)
//            mo.apply(dto: dto)
//            
//            CoreDataService.shared.saveContext(complition: complition)
//        }
//    }
//    
//    func update(dto: DateNotificationDTO,
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
//    func updateOrCreate(dto: DateNotificationDTO,
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
