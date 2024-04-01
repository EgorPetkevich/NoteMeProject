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
    var searchEditing: String? { get set }
    var hideTableView: (() -> Void)? { get set }
    var showTableView: (() -> Void)? { get set }
    var placesNotFound: (() -> Void)? { get set }
    
    func selectDidTap(regionImageView: UIImageView)
    func searchBarDidTap(regionImageView: UIImageView)
    func makeTableView() -> UITableView
    func searchBarSearchButtonDidTap(with text: String?)
    func searchBarCancelButtonDidTap()
    @objc func cancelDidTap()
}

final class LocationVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var searchTableView: UITableView = viewModel.makeTableView()
    private lazy var locatinionManager: CLLocationManager = .init()
    private lazy var mapView: MKMapView = viewModel.mapView
    private lazy var placesNotFoundView: UIView = .placesNotFoundView()
    private lazy var searchBar: UISearchBar = .createSearchBar()
    
    private lazy var regionImageView: UIImageView = {
        let image = UIImageView(image: .Location.region)
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
        searchTableView.isHidden = true
        
        setup()
        setupConstrains()
    }
    
    private func bind() {
        searchBar.delegate = self
        placesNotFoundView.isHidden = true
        
        viewModel.hideTableView = { [weak self] in
            self?.searchTableView.isHidden = true
            self?.searchBar.text = ""
            self?.view.endEditing(true)
        }
        viewModel.showTableView = { [weak self] in
            self?.searchTableView.isHidden = false
        }
        viewModel.placesNotFound = { [weak self] in
            self?.placesNotFoundView.isHidden = false
        }
    }
    
    private func setup() {
        view.backgroundColor = .appContentWhite
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(selectButton)
        view.addSubview(cancelButton)
        
        contentView.addSubview(mapView)
        contentView.addSubview(searchBar)
        
        mapView.addSubview(regionImageView)
        mapView.addSubview(searchTableView)
        
        searchTableView.addSubview(placesNotFoundView)
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(selectButton.snp.centerY)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(56.0)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalToSuperview()
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
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        regionImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(mapView.snp.width).dividedBy(4)
        }
        
        placesNotFoundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(78)
        }
        
    }
    
    @objc private func selectButtonDidTap() {
        viewModel.selectDidTap(regionImageView: regionImageView)
    }
    
}

extension LocationVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        placesNotFoundView.isHidden = true
        viewModel.searchBarDidTap(regionImageView: regionImageView)
        viewModel.searchEditing = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        placesNotFoundView.isHidden = true
        viewModel.searchEditing = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarSearchButtonDidTap(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        viewModel.searchBarCancelButtonDidTap()
    }
    
}
