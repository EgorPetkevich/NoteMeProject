//
//  FileDataWorker+Login.swift
//  NoteMe
//
//  Created by George Popkich on 23.05.24.
//

import Foundation

struct LoginFileDataWorker: LoginFileDataWorkerUseCaseProtocol {
    
    private let fileDataWorker: FileDataWorker
    
    init(fileDataWorker: FileDataWorker) {
        self.fileDataWorker = fileDataWorker
    }
    
    func download() {
        self.fileDataWorker.download()
    }
    
}
