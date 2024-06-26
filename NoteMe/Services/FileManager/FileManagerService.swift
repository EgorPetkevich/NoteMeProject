//
//  FileManagerService.swift
//  NoteMe
//
//  Created by George Popkich on 18.03.24.
//

import UIKit

final class FileManagerService {
    
    enum NameOfDirectory: String {
        case userLocationScreenshots
    }
    
    static let instansce = FileManagerService()
    
    private init() { }
    
    static func creatDierectory(name directory: NameOfDirectory) {
        let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first!
        let url = documentURL.appendingPathComponent(directory.rawValue)
        
        do {
            try FileManager.default.createDirectory(at: url,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch {
            print("Error creating directory: \(error)")
        }
    }
    
    func save(directory: NameOfDirectory, image: UIImage, with path: String) {
        let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first!
        let userPhotosURL = documentURL.appendingPathComponent(directory.rawValue)
        
        let userProfileURL = userPhotosURL.appendingPathComponent("\(path).jpg")
        
        if let data = image.jpegData(compressionQuality: 1.0){
            do {
                try data.write(to: userProfileURL)
                print("Successfully wrote to file!")
            } catch {
                print("Error writing to file: \(error)")
            }
        }
    }
    
    func read(directory: NameOfDirectory, with path: String) -> UIImage? {
        let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first!
        let userPhotosURL = documentURL.appendingPathComponent(directory.rawValue)
        
        let userProfileURL = userPhotosURL.appendingPathComponent("\(path).jpg")
        
        do {
            let data = try Data(contentsOf: userProfileURL)
            if let image = UIImage(data: data) {
                print("File contents: \(image)")
                return image
            }
        } catch {
            print("Error reading file: \(error)")
        }
        return nil
    }
    
}


extension FileManagerService: FileDataWorkerFileManagerServiceUseCaseProtocol {
    func save(image: UIImage, with path: String) {
        self.save(directory: .userLocationScreenshots, image: image, with: path)
    }
    
    func read(with path: String) -> UIImage? {
        self.read(directory: .userLocationScreenshots, with: path)
    }
    
}
