//
//  NotificatoinFilterView.swift
//  NoteMe
//
//  Created by George Popkich on 13.03.24.
//

import UIKit
import SnapKit

enum NotificationFilterType: CaseIterable {
    case all
    case date
    case timer
    case location
    
    var title: String {
        switch self {
        case .all: return "All"
        case .date: return "Date"
        case .timer: return "Timer"
        case .location: return "Location"
        }
    }
}

protocol NotificationFilterViewDelegate: AnyObject {
    func notificationFilterView(_ filterView: NotificationFilterView,
                                didSelect type: NotificationFilterType)
}

final class NotificationFilterView: UIView {
    
    private enum Const {
        static let minimumLineSpacing: CGFloat = 8.0
        static let horizontalInset: CGFloat = 20.0
        static let contentHeight: CGFloat = 32.0
        static let minimumItemWidth: CGFloat = 51.0
        static let titlePadding: CGFloat = 8.0
    }
        
    private lazy var layout : UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Const.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: .zero,
                                           left: Const.horizontalInset,
                                           bottom: .zero,
                                           right: Const.horizontalInset)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(NotificationFilterCell.self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    weak var delegate: NotificationFilterViewDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        addSubview(collectionView)
    }
    
    private func setupConstrains() {
        
        collectionView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        collectionView.selectItem(at: .init(row: .zero,
                                            section: .zero),
                                  animated: false,
                                  scrollPosition: .left)
    }
    
}

extension NotificationFilterView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return NotificationFilterType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: NotificationFilterCell = collectionView.dequeue(at: indexPath)
        cell.setup(with: NotificationFilterType.allCases[indexPath.row])
        return cell
    }
    
}

extension NotificationFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.notificationFilterView(
            self,
            didSelect: NotificationFilterType.allCases[indexPath.row])
    }
    
}

extension NotificationFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let typeTitle = NotificationFilterType.allCases[indexPath.row].title
        let calculatedWidth = typeTitle.minimumWidthToDisplay(font: .appFont.withSize(17.0),
                                                              height: Const.contentHeight)
                            + Const.titlePadding * 2
        let width = calculatedWidth < Const.minimumLineSpacing
                    ? Const.minimumItemWidth : calculatedWidth
        return CGSize(width: width, height: Const.contentHeight)
    }
    
}
