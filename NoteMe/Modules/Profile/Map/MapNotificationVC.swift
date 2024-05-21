//
//  MapNotificationVC.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit
import MapKit

@objc protocol MapNotificationViewModelProtocol {
    var mapView: MKMapView { get set }
    @objc func cancelDidTap()
}

final class MapNotificationVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var locatinionManager: CLLocationManager = .init()
    
    private lazy var mapView: MKMapView = viewModel.mapView
    private lazy var backButton: UIButton =
        .yellowRoundedButton("Back")
        .withAction(viewModel,
                    #selector(LocationViewModelProtocol.cancelDidTap))
    
    private var viewModel: MapNotificationViewModelProtocol
    
    init(viewModel: MapNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstrains()

    }
    
    
    private func setupUI() {
        view.backgroundColor = .appContentWhite
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(backButton)
        
        contentView.addSubview(mapView)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(backButton.snp.centerY)
        }
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}

