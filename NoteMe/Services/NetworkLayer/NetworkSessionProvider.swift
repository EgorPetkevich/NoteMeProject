//
//  NetworkSessionProvider.swift
//  NoteMe
//
//  Created by George Popkich on 19.03.24.
//

import Foundation

final class NetworkSessionProvider {
    
    func send<Request: NetworkRequest>(request: Request,
                                       complition: @escaping 
    (Request.ResponseModel?) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        URLSession.shared.dataTask(with: urlRequest) { responseData, 
                                                       response,
                                                       error in
            if let error {
                print("[NetworkLayer]: Error -", error.localizedDescription)
                complition(nil)
            } else if let responseData,
                      let ResponseModel = try? JSONDecoder()
                .decode(Request.ResponseModel.self, from: responseData) {
                complition(ResponseModel)
            } else {
                print("[NetworkLayaer]: Decode error to type \(Request.ResponseModel.self)")
            }
            
        }.resume()
    }
    
}

