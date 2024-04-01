//
//  LocationNetworkService+Search.swift
//  NoteMe
//
//  Created by George Popkich on 30.03.24.
//

import UIKit
import CoreLocation

struct LocationNetworkServiceUseCase: LocationNetworkServiceUseCaseProtocol {
    
    private var service: LocationNetworkService
    
    init(service: LocationNetworkService) {
        self.service = service
    }
    
    func getNearBy(coordinates: CLLocationCoordinate2D,
                   complition: @escaping ([NearByResponseModel.Result]) -> Void) {
        service.getNearBy(coordinates: coordinates,
                          complition: complition)
    }
    
    func getPlaceSearch(coordinates: CLLocationCoordinate2D, 
                        query: String,
                        complition: @escaping ([NearByResponseModel.Result])
                        -> Void) {
        service.getPlaceSearch(coordinates: coordinates, 
                               query: query,
                               complition: complition)
    }
    
}
