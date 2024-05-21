//
//  FireBaseStorageService.swift
//  NoteMe
//
//  Created by George Popkich on 7.05.24.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

enum FireBaseStorageError: String, LocalizedError {
    case clientIdIsNil = "Firebase client id is nil"
    case imageToDataFailed = "Image cannot parthed to png data"
    case dataToImageFaild = "Data cannot be used to image"
    case dataIsNill = "Download successed, BUT data is nil"
    
    var errorDescription: String? {
        return self.rawValue
    }
}

final class FireBaseStoregeService {
    
    private enum Paths {
        static let location = "locationNotification"
    }
    
    typealias UploadImageModel = (id: String, image: UIImage)
    typealias UploadComplitionHandler = (Bool, URL?) -> Void
    typealias DownloadImageCompletion = (Bool, UIImage?) -> Void
    private let queue = DispatchQueue(label: "com.noteme.firebase.storage",
                                      qos: .utility,
                                      attributes: .concurrent)
    
    private var storage: StorageReference = {
        Storage.storage().reference()
    }()
    
    
    private var clientId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func upload(model: UploadImageModel, complition: UploadComplitionHandler?) {
        guard let clientId else {
            FireBaseStorageError.clientIdIsNil.log()
            complition?(false, nil)
            return
        }
        
        queue.async { [weak self] in
            guard let data = model.image.pngData() else {
                FireBaseStorageError.imageToDataFailed.log()
                complition?(false, nil)
                return
            }
            let ref = self?.storage.child("\(Paths.location)/\(clientId)/\(model.id).png")
            
            ref?.putData(data, completion: { metadata, error in
                
                guard error == nil else {
                    error?.log(root: "\(FireBaseStorageError.self)")
                    complition?(false, nil)
                    return
                }
                
            ref?.downloadURL { fileUrl, error in
              
                guard error == nil else {
                    error?.log(root: "\(FireBaseStorageError.self)")
                    complition?(false, nil)
                    return
                }
                complition?(true, fileUrl)
            }
        })
        }
    }
    
    func download(fileName: String, completion: DownloadImageCompletion?) {
        guard let clientId else {
            completion?(false, nil)
            return
        }
        let ref = self.storage.child("\(Paths.location)/\(clientId)/\(fileName).png")
        //Max file size 10mb
        
        ref.getData(maxSize: 10*1024*1024) { data, error in
            if let error {
                error.log(root: "\(FireBaseStorageError.self)")
                completion?(false, nil)
            } else if let data {
                guard let image = UIImage(data: data)
                else {
                    FireBaseStorageError.dataToImageFaild.log()
                    completion?(false, nil)
                    return
                }
                completion?(true, image)
            } else {
                FireBaseStorageError.dataIsNill.log()
                completion?(false, nil)
            }
        }
    }
    
}
