//
//  DTODescription.swift
//  Storage
//
//  Created by George Popkich on 7.02.24.
//

import Foundation
import CoreData

public protocol MODescription: NSManagedObject, NSFetchRequestResult {
    associatedtype DTO: DTODescription
    
    func apply(dto: DTO)
}

public protocol DTODescription {
    associatedtype DTO
    associatedtype MO:  MODescription
    var id: String { get set }
    
    init?(mo: MO)
}

public protocol DTOMapable {
    static func makeFetchRequest<MO: NSFetchRequestResult>() -> NSFetchRequest<MO>
}
