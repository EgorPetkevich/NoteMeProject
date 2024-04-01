//
//  LocationNetworkService.swift
//  NoteMe
//
//  Created by George Popkich on 19.03.24.
//

import Foundation
import CoreLocation

final class LocationNetworkService {
    
    private let session = NetworkSessionProvider()
    
    func getNearBy(coordinates: CLLocationCoordinate2D,
                   complition: @escaping([NearByResponseModel.Result]) -> Void) {
        let requestModel = NearByRequestModel(coordinates: coordinates)
        let request = NearByRequest(model: requestModel)
        session.send(request: request) { response in
            complition(response?.results ?? [])
        }
    }
    
    func getPlaceSearch(coordinates: CLLocationCoordinate2D,
                        query: String,
                        complition: @escaping([NearByResponseModel.Result]) -> Void) {
        let requestModel = PlaceSearchRequestModel(query: query,
                                                    coordinates: coordinates)
        let request = PlaceSearchRequest(model: requestModel)
        session.send(request: request) { response in
            complition(response?.results ?? [])
        }
    }
}
