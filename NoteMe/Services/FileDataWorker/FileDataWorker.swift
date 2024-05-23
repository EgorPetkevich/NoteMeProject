//
//  FileDataWorker.swift
//  NoteMe
//
//  Created by George Popkich on 21.05.24.
//

import UIKit
import Storage

protocol FileDataWorkerFileManagerServiceUseCaseProtocol {
    func save(image: UIImage,
              with path: String)
    func read(with path: String) -> UIImage?
}

protocol FileDataWorkerFireBaseStorageServiceUseCaseProtocol {
    func upload(model: FireBaseStorageService.UploadImageModel,
                complition: FireBaseStorageService.UploadComplitionHandler?)
    func download(fileName: String, 
                  completion: FireBaseStorageService.DownloadImageCompletion?)
    
}

final class FileDataWorker {
    
    typealias ComplitionHandler = (Bool) -> Void
    
    private var fileManagerService: FileDataWorkerFileManagerServiceUseCaseProtocol
    private var fireBaseStorageService: FileDataWorkerFireBaseStorageServiceUseCaseProtocol
    private var storage: LocationNotificationStorage
    
    init(fileManagerService: FileDataWorkerFileManagerServiceUseCaseProtocol, 
         fireBaseStorageService: FileDataWorkerFireBaseStorageServiceUseCaseProtocol,
         storage: LocationNotificationStorage) {
        self.fileManagerService = fileManagerService
        self.fireBaseStorageService = fireBaseStorageService
        self.storage = storage
    }
    
    func save(image: UIImage, id: String) {
        fileManagerService.save(image: image,
                                with: id)
        fireBaseStorageService.upload(model: (id, image), complition: nil)
    }
    
    func getImage(id: String, complition: @escaping ((UIImage?) -> Void)) {
        if let image = fileManagerService
            .read(with: id) {
            complition(image)
        }
        else {
            fireBaseStorageService
                .download(fileName: id) { [weak self] completion, image in
                    guard let image, completion else { return }
                    self?.imageNotFoundInFileManager(id: id, image: image)
                    complition(image)
            }
        }
    }
    
    func download() {
        storage.fetch().forEach { dto in
            getImage(id: dto.id) { _ in }
        }
    }
    
    private func imageNotFoundInFileManager(id: String, image: UIImage) {
        fileManagerService.save(image: image, with: id)
    }
    
}
