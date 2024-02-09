//
//  DTODescription.swift
//  Storage
//
//  Created by George Popkich on 7.02.24.
//

import Foundation
import CoreData

public protocol DTODescription {
    associatedtype DTO
    associatedtype MO: NSManagedObject, NSFetchRequestResult, MODescription
    
    var id: String { get set }
    
    init?(mo: MO)
}

public protocol MODescription {
    func apply(dto: any DTODescription)
}
