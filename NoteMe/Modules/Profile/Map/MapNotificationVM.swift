//
//  MapVM.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import UIKit
import CoreLocation
import MapKit
import Storage

protocol MapNotificationCoordinatorProtocol: AnyObject {
    func finish()
}

protocol MapNotificationStorageUseCaseProtocol {
    func fetch() -> [LocationNotificationDTO]
}

final class MapNotificationVM: NSObject, MapViewModelProtocol {
    
    private var locationManager: CLLocationManager
    private var mapRegion: MKCoordinateRegion?
    private let storage: MapNotificationStorageUseCaseProtocol
    
    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = false
        
        mapView.register(LocationPinView.self,
                         forAnnotationViewWithReuseIdentifier:
                            "\(LocationPinView.self)")
        return mapView
    }()
    
    private weak var coordinator: MapNotificationCoordinatorProtocol?
    
    init(coordinator: MapNotificationCoordinatorProtocol? = nil,
         locationManager: CLLocationManager) {
        self.coordinator = coordinator
        self.locationManager = locationManager
        super.init()
        mapView.delegate = self
        askPermission()
        setupAnnotations()
    }
    
    private func setupAnnotations() {
        let galleryPin = LocationPin(coordinate: .init(latitude: 53.908538,
                                                       longitude:  27.548427),
                                     title: "Gallery Minsk",
                                     subtitle: "Mall")
        
        mapView.addAnnotation(galleryPin)
    }
    
    private func askPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
}
    
extension MapNotificationsVM: CLLocationManagerDelegate {
    
    
}

extension MapNotificationsVM: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(LocationPinView.self)", for: annotation)
        return pinView
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        UIView.animate(withDuration: 0.1) {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func mapView(_ mapView: MKMapView, 
                 didDeselect view: MKAnnotationView) {
        UIView.animate(withDuration: 0.1) {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}


private final class LocationPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}

final class LocationPinView: MKAnnotationView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .Profile.location)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    override init(annotation: MKAnnotation?,
                  reuseIdentifier: String?) {
        super.init(annotation: annotation,
                   reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        frame.size = .init(width: 40.0, height: 90.0)
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY)
            make.top.equalTo(self.snp.top)
            make.horizontalEdges.equalTo(self.snp.horizontalEdges)
        }
    }
}

    
