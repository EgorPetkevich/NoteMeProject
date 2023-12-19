//
//  HomeAssembler.swift
//  NoteMe
//
//  Created by George Popkich on 18.12.23.
//

import UIKit

final class HomeAssembler {
    
    private init() {}
    
    static func make() -> UIViewController {
        let vc = HomeVC()
        return vc
    }
    
}
