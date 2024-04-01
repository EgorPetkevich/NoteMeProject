//
//  PlaceSearchRequest.swift
//  NoteMe
//
//  Created by George Popkich on 25.03.24.
//

import Foundation
import CoreLocation

///
///{
/// "results": [{
///     "distance": 22,
///     "geocodes": {
///     "main": {
///         "latitude": 53.926066,
///         "longitude": 27.592507
///         }
///     },
///     "name": "Молодёжный центр \"Айсберг\""
///     }, ....
///     ]
///}
///
//struct PlaceSearchResponseModel: Decodable {
//    struct Result: Decodable {
//        struct Geocodes: Decodable {
//            struct Main: Decodable {
//                let latitude: Double
//                let longitude: Double
//            }
//            let main: Main
//        }
//        
//        let distance: Int
//        let geocodes: Geocodes
//        let name: String
//    }
//    
//    let results: [Result]
//}

struct PlaceSearchRequestModel {
    let query: String
    let coordinates: CLLocationCoordinate2D
    let radius: Int32 = 1000
}

struct PlaceSearchRequest: NetworkRequest {
    
    typealias ResponseModel = NearByResponseModel
    
    var url: URL {
        let baseUrl = ApiPaths.placeSerch
        let ll = "\(model.coordinates.latitude),\(model.coordinates.longitude)"
        let radius = "\(model.radius)"
        let query = model.query
        let parameters = "ll=\(ll)&radius=\(radius)&query=\(query)"
        return URL(string: baseUrl + "?" + parameters)!
    }
    var method: NetworkHTTPMethod { .get }
    var headers: [String : String] {
        ["Authorization" : ApiToken.fourSquareToken]
    }
    var body: Data? { nil }
    
    let model: PlaceSearchRequestModel
    
}

