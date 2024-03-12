//
//  LocationVC.swift
//  NoteMe
//
//  Created by George Popkich on 11.03.24.
//

import UIKit
import MapKit

@objc protocol LocationViewModelProtocol {
    var mapView: MKMapView { get set }
    
    func selectDidTap(regionImageView: UIImageView)
    @objc func cancelDidTap()
}

final class LocationVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    
    private lazy var locatinionManager: CLLocationManager = .init()
    
    private lazy var mapView: MKMapView = viewModel.mapView
    
    private lazy var regionImageView: UIImageView = {
        let image = UIImageView(image: .init(named: "region"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var selectButton: UIButton =
        .yellowRoundedButton("Select")
        .withAction(self, #selector(selectButtonDidTap))
    
    private lazy var cancelButton: UIButton =
        .cancelButton(.Auth.resetPassCancelButton)
        .withAction(viewModel,
                    #selector(LocationViewModelProtocol.cancelDidTap))
    
    private var viewModel: LocationViewModelProtocol

    init(viewModel: LocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        setupConstrains()
    }
    
    private func bind() {
        
    }
    
    private func setup() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(selectButton)
        view.addSubview(cancelButton)
        
        contentView.addSubview(mapView)
        
        mapView.addSubview(regionImageView)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(selectButton.snp.centerY)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        regionImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(mapView.snp.width).dividedBy(4)
        }
    }
    
    @objc private func selectButtonDidTap() {
        viewModel.selectDidTap(regionImageView: regionImageView)
    }
    
}

