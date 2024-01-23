//
//  Container.swift
//  NoteMe
//
//  Created by George Popkich on 22.01.24.
//

import Foundation

final class Container {
    
    private var container: [String: Any] = [:]
    
    private var lazyContainer: [String: () -> Any] = [:]
    
//    func register<Type: Any>(_ service: Type) {
//        container["\(Type.self)"] = service
//    }
    
    func register<Type: Any>(_ initalizer: @escaping () -> Type) {
        lazyContainer["\(Type.self)"] = initalizer
    }
    
    func resolve<Type: Any>() -> Type {
        if let cache = container["\(Type.self)"] as? Type {
            return cache
        }
        
        let new = lazyContainer["\(Type.self)"]?() as! Type
        container["\(Type.self)"] = new
        return new
    }
    
}
