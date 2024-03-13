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

final class LocationVM: LocationViewModelProtocol {
    
    private var locationManager: CLLocationManager = .init()
    
    var delegate: LocationDelegate
    
    private var mapRegion: MKCoordinateRegion?
    var regionImageView: UIImageView?
    
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    
    weak var coordinator: LocationCoordinatorProtocol?
    
    private var locationProperties =  LocationProperties()
    

    init(coordinator: LocationCoordinatorProtocol, 
         locationProperties: LocationProperties?,
         delegate: LocationDelegate) {
        self.coordinator = coordinator
        self.locationProperties = locationProperties ?? LocationProperties()
        self.delegate = delegate
        
        bind()
    }
    
    private func bind() {
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
    
    func selectDidTap(regionImageView: UIImageView) {
        setLocationPar(regionImageView)
        makeScreenshot(regionImageView)
        
        delegate.updateLocationProperties(locationProperties)
        
        coordinator?.finish()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
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
        let radiusStr = "\(radius)"
        print("radius", radius, Double(radius))
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

//extension LocationVM: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//    }
//}
