//
//  DTODescription.swift
//  Storage
//
//  Created by George Popkich on 7.02.24.
//

import Foundation
import CoreData

public protocol MODescription: NSManagedObject, NSFetchRequestResult {
    func apply(dto: any DTODescription)
    func toDTO() -> (any DTODescription)?
}

public protocol DTODescription {
    associatedtype MO: MODescription
    
    var id: String { get set }
    var date: Date { get set }
    var title: String { get set }
    var subtitle: String? { get set }
    var completedDate: Date? { get set }
    
    static func fromMO(_ mo: MO) -> Self?
    
}

