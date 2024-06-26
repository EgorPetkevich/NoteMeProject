//
//  CollectionView+Register.swift
//  NoteMe
//
//  Created by George Popkich on 18.03.24.
//

import UIKit

extension UICollectionView {
    
    func dequeue<CellType: UICollectionViewCell>(at indexPath: IndexPath) -> CellType {
        return self.dequeueReusableCell(withReuseIdentifier:"\(CellType.self)",
                                        for: indexPath) as! CellType
    }
    
    func register<CellType: UICollectionViewCell>(_ type: CellType.Type) {
        register(type.self, forCellWithReuseIdentifier: "\(type.self)")
    }
    
}
