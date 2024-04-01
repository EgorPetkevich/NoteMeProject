//
//  SearchBar+Set.swift
//  NoteMe
//
//  Created by George Popkich on 1.04.24.
//

import UIKit

extension UISearchBar {
    
     static func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.text = ""
        searchBar.backgroundColor = .appInfoWhite
        searchBar.tintColor = .appYellow
        searchBar.showsCancelButton = true
        return searchBar
    }
    
}
