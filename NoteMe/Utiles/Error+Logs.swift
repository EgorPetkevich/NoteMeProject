//
//  Error+Logs.swift
//  NoteMe
//
//  Created by George Popkich on 7.05.24.
//

import Foundation

extension Error {
    
    func log(root: String? = nil) {
        let finalRoot = root ?? "\(Self.self)"
        //log error
        print("[\(finalRoot)]", localizedDescription)
    }
    
}
