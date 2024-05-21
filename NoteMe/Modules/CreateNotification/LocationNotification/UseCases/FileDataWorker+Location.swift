//
//  FileDataWorker+Location.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import UIKit

struct LocationFileDataWorker: LocationNotificationFileDataWorkerUseCaseProtocol {
    
    private var fileDataWorker: FileDataWorker
    
    init(fileDataWorker: FileDataWorker) {
        self.fileDataWorker = fileDataWorker
    }
    
    func save(image: UIImage, id: String) {
        fileDataWorker.save(image: image, id: id)
    }
    
    func getImage(id: String, complition: @escaping (UIImage?) -> Void) {
        fileDataWorker.getImage(id: id, complition: complition)
    }
    
    
}
