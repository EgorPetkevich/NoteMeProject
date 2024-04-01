//
//  LocationVM.swift
//  NoteMe
//
//  Created by George Popkich on 11.03.24.
//

import UIKit
import MapKit
import SwiftUI

protocol LocationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol SearchLocationAdapterProtocol {
    var selectSearchResualt: ((NearByResponseModel.Result) -> Void)? { get set }
    
    func makeTableView() -> UITableView
    func reloadDate(_ searchList: [NearByResponseModel.Result])
    func reloadTableView()
}

protocol LocationNetworkServiceUseCaseProtocol {
    func getNearBy(coordinates: CLLocationCoordinate2D,
                   complition: @escaping([NearByResponseModel.Result]) -> Void)
    func getPlaceSearch(coordinates: CLLocationCoordinate2D,
                        query: String,
                        complition: @escaping([NearByResponseModel.Result])
                        -> Void)
}

final class LocationVM: LocationViewModelProtocol {
    
    var delegate: LocationDelegate
    var hideTableView: (() -> Void)?
    var showTableView: (() -> Void)?
    var placesNotFound: (() -> Void)?
    
    var searchResualtDidSelect: NearByResponseModel.Result? {
        didSet {
            placeDidSelect(searchResualt: searchResualtDidSelect)
        }
    }
    
    var searchEditing: String? {
        didSet {
            searchPlaces(with: searchEditing)
        }
    }

    private var locationManager: CLLocationManager = .init()
    private var adapter: SearchLocationAdapterProtocol
    private var locationService: LocationNetworkServiceUseCaseProtocol
    
    private var mapRegion: MKCoordinateRegion?
    var regionImageView: UIImageView?
    
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    
    weak var coordinator: LocationCoordinatorProtocol?
    
    private var locationProperties = LocationProperties()
    private var location: CLLocationCoordinate2D {
        .init(
            latitude: locationProperties.latitude ?? 0.0,
            longitude: locationProperties.longitude ?? 0.0
        )
    }

    init(adapter: SearchLocationAdapter,
         locationService: LocationNetworkServiceUseCaseProtocol,
         coordinator: LocationCoordinatorProtocol,
         locationProperties: LocationProperties?,
         delegate: LocationDelegate) {
        self.adapter = adapter
        self.locationService = locationService
        self.coordinator = coordinator
        self.locationProperties = locationProperties ?? LocationProperties()
        self.delegate = delegate
        
        bindAdapter()
        setLocationOnMap()
    }
    
    private func bindAdapter() {
        adapter.selectSearchResualt = { [weak self] searchResualt in
            self?.searchResualtDidSelect = searchResualt
        }
    }
    
    private func setLocationOnMap(){
        askPermission()
        guard
            let latitude = locationProperties.latitude,
            let longitude = locationProperties.longitude,
            let radius = locationProperties.radius
        else { return }
        
        let center =  CLLocationCoordinate2D(latitude: latitude,
                                             longitude: longitude)
        let distance = CLLocationDistance(radius)
        let range = distance * 8
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: range,
                                        longitudinalMeters: range)
        self.mapView.setRegion(region, animated: false)
    }
    
    func searchBarSearchButtonDidTap(with text: String?) {
        if let text, text != "" {
            locationService.getPlaceSearch(coordinates: location,
                                           query: text) { [weak self] resualt in
                self?.placeDidSelect(searchResualt: resualt.first, searchText: text)
            }
        }
    }
    
    func searchBarCancelButtonDidTap() {
        hideTableView?()
    }
    
    func makeTableView() -> UITableView {
        return adapter.makeTableView()
    }
    
    func searchBarDidTap(regionImageView: UIImageView) {
        showTableView?()
        setLocationPar(regionImageView)
    }
    
    func selectDidTap(regionImageView: UIImageView) {
        setLocationPar(regionImageView)
        makeScreenshot(regionImageView)
        
        delegate.updateLocationProperties(locationProperties)
        
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func placeDidSelect(searchResualt model: NearByResponseModel.Result?,
                           searchText: String? = nil) {
        if let resualt = model, resualt.name == searchText {
            locationProperties.latitude = resualt.geocodes.main.latitude
            locationProperties.longitude = resualt.geocodes.main.longitude
            DispatchQueue.main.async {
                self.setLocationOnMap()
                self.hideTableView?()
            }
        }else {
            DispatchQueue.main.async {
                self.reloadTableView(searchList: [])
                self.placesNotFound?()
            }
        }
    }
    
    private func searchPlaces(with text: String?) {
        if let text, text != "" {
            locationService.getPlaceSearch(coordinates: location,
                                           query: text) { [weak self] resualt in
                self?.reloadTableView(searchList: resualt)
            }
        } else {
            locationService.getNearBy(coordinates: location) { [weak self] resualt in
                self?.reloadTableView(searchList: resualt)
            }
        }
    }
    
    private func reloadTableView(searchList: [NearByResponseModel.Result]) {
        DispatchQueue.main.async {
            self.adapter.reloadDate(searchList)
        }
    }
    
    private func askPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    private func setLocationPar(_ imageView: UIView) {
        
        mapRegion = mapView.convert(imageView.bounds,
                                    toRegionFrom: imageView)
        guard let mapRegion else { return }
        
        let centerLoc = CLLocation(latitude: mapRegion.center.latitude, 
                                   longitude: mapRegion.center.longitude)
        let topLoc = CLLocation(
            latitude: mapRegion.center.latitude - mapRegion.span.latitudeDelta / 2,
                                longitude: mapRegion.center.longitude)
        let radius = centerLoc.distance(from: topLoc)
        
        locationProperties.latitude =  mapRegion.center.latitude
        locationProperties.longitude = mapRegion.center.longitude
        locationProperties.radius = Double(radius)
    }
    
    private func makeScreenshot(_ regionImageView: UIView) {
        let screenshotSize = CGSize(width: mapView.frame.width,
                                    height: regionImageView.frame.height * 2)
       
        let contentRect = CGRect(origin: CGPoint(x: 0,
                                                 y: -(mapView.bounds.height / 2 - screenshotSize.height / 2)),
                                 size: mapView.bounds.size)
        UIGraphicsBeginImageContextWithOptions(screenshotSize, false,
                                               UIScreen.main.scale)
        mapView.drawHierarchy(in: contentRect, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        locationProperties.screenLoc = image
    }
    
}

public struct LocationProperties {
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var radius: Double?
    var screenLoc: UIImage?
    
    init(){}
    
}


struct NotificationRequest {
    
    let content = UNMutableNotificationContent()
    let triger: UNLocationNotificationTrigger
    let id = UUID().uuidString
    
    func request() {
        let request = UNNotificationRequest(identifier: id,
                              content: content,
                              trigger: triger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
