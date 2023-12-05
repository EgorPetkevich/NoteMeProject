//
//  ParametersHelper.swift
//  NoteMe
//
//  Created by George Popkich on 28.11.23.
//

import Foundation

final class ParametersHelper {
    
    enum ParameterKey: String {
        case authenticatied
        case onboarded
        case onboardDidFinish
    }
    
    private static var ud: UserDefaults = .standard
    
    private init() {}
    
    static func set(_ key: ParameterKey, value: Bool) {
        ud.setValue(value, forKey: key.rawValue)
    }
    
    static func get(_ key: ParameterKey) -> Bool {
        return ud.bool(forKey: key.rawValue)
    }
    
}
