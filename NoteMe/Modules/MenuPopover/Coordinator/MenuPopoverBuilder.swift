//
//  MenuPopoverBuilder.swift
//  NoteMe
//
//  Created by George Popkich on 27.02.24.
//

import UIKit

final class MenuPopoverBuilder {
    
    private init() {}
    
    static func buildAddMenu(delegate: MenuPopoverDelegate, 
                             sourseView: UIView) -> UIViewController {
        let menu =  build(delegate: delegate,
                     actions: [.calendar, .location, .timer],
                     sourseView: sourseView)
        menu.popoverPresentationController?.permittedArrowDirections = .down
        return menu
    }
    
    static func buildEditMenu(delegate: MenuPopoverDelegate, 
                              sourseView: UIView) -> UIViewController {
        let menu =  build(delegate: delegate,
                     actions: [.edit, .delete],
                     sourseView: sourseView)
        menu.popoverPresentationController?.permittedArrowDirections = .up
        return menu
    }
    
    private static func build(delegate: MenuPopoverDelegate,
                              actions: [MenuPopoverVC.Action], 
                              sourseView: UIView) -> UIViewController {
        let adapter = MenuPopoverAdapter(actions: actions)
        return MenuPopoverVC(delegate: delegate, 
                             adapter: adapter,
                             sourseView: sourseView)
    }
}
