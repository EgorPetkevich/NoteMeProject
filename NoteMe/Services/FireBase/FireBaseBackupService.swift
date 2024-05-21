//
//  FireBaseBackupService.swift
//  NoteMe
//
//  Created by George Popkich on 9.04.24.
//

import Foundation
import FirebaseCore
import FirebaseDatabaseInternal
import FirebaseAuth
import Storage


final class FireBaseBackupService {
    
    private let backupQueue: DispatchQueue = .init(label: "com.noteme.backup",
                                           qos: .background,
                                           attributes: .concurrent)
    
    private var userId: String? {
        return Auth.auth().currentUser?.uid
    }
    
    private var ref: DatabaseReference {
        return Database.database().reference()
    }
    
    func backup(dto: any DTODescription) {
        guard let userId else { return }
        backupQueue.async { [ref] in
            let backupModel = BackupModel(dto: dto)
            let dict = backupModel.buidDict()
            
            ref
                .child("notification")
                .child(userId)
                .child(dto.id).setValue(dict)
        }
    }
    
    func delete(id: String) {
        guard let userId else { return }
        backupQueue.async { [ref] in
            ref
                .child("notification")
                .child(userId)
                .child(id)
                .removeValue()
        }
    }
    
    func loadBackup(_ complition: @escaping (([any DTODescription]) -> Void)) {
        guard let userId else { return }
        ref
            .child("notification")
            .child(userId)
            .getData { [weak self] error, snapshot in
                self?.backupQueue.async {
                    guard let snapshotDict = snapshot?.value as? [String: Any]
                    else { complition([])
                        return }
                    
                    let value = snapshotDict.map {_, value in value }
                    
                    guard
                        //                    let value = snapshot?.value,
                        let data = try? JSONSerialization
                            .data(withJSONObject: value),
                        let backupModels = try? JSONDecoder()
                            .decode([BackupModel].self,
                                    from: data)
                    else {  // log Error
                        complition([])
                        return
                    }
                    complition(backupModels.map { $0.dto })
                }
            }
    }
    
}
