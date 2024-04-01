//
//  FileManagerUseCase+Image.swift
//  NoteMe
//
//  Created by George Popkich on 19.03.24.
//

import UIKit

struct LocationFileManagerUseCase:
    LocationNotificationFileManagerServiceUseCaseProtocol {
    
    private let fileManagerService: FileManagerService
    
    init(fileManagerService: FileManagerService) {
        self.fileManagerService = fileManagerService
    }
    
    func save(image: UIImage, with path: String) {
        fileManagerService.save(directory: .userLocationScreenshots,
                                image: image,
                                with: path)
    }
    
    func takeImage(with path: String) -> UIImage? {
        fileManagerService.read(directory: FileManagerService.NameOfDirectory
            .userLocationScreenshots,
                                with: path)
    }
    
}
