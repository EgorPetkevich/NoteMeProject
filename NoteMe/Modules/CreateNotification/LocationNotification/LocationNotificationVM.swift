//
//  LocationNotificationVM.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import Storage
import CoreLocation

protocol LocationNotificationCoordinatorProtocol: AnyObject {
    func editMap(locationProperties: LocationProperties?,
                 delegate: LocationDelegate)
    func finish()
}

protocol KeyboardHelperLocationNotificationUseCaseProtocol {
    @discardableResult
    func onWillShow(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
    @discardableResult
    func onWillHide(_ handler: @escaping (CGRect) -> Void) -> KeyboardHelper
}

protocol LocationDelegate {
    func updateLocationProperties(_ properties: LocationProperties)
}

protocol LocationNotificationServiceUseCaseProtocol {
    func updateOrCreate(dto: LocationNotificationDTO,
                        circleRegion: CLCircularRegion?,
                        notifyOnEntry: Bool,
                        notifyOnExit: Bool,
                        repeats: Bool)
}

protocol LocationNotificationDataWorkerUseCaseProtocol {
    func updateOrCreate(dto: LocationNotificationDTO)
}

protocol LocationNotificationFileDataWorkerUseCaseProtocol {
    func save(image: UIImage, id: String) 
    func getImage(id: String, complition: @escaping (UIImage?) -> Void)
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol,
                                    LocationDelegate {
    
    typealias LocSet = (title: String, comment: String)

    var editTitle: String?
    var editComment: String?
    var editImage: UIImage?
    
    var locImage: ((UIImage?) -> Void)?
    
    var catchTitleError: ((String?) -> Void)?
    var catchLocationError: ((String?) -> Void)?
    
    var keyboardFrameChanged: ((CGRect) -> Void)?
    
    private var locationProperties = LocationProperties()
    
    private let keyboardHelper: KeyboardHelperLocationNotificationUseCaseProtocol
    private var dataWorker: LocationNotificationDataWorkerUseCaseProtocol
    private var dto: LocationNotificationDTO?
    private var fileDataWorker: LocationNotificationFileDataWorkerUseCaseProtocol
    private var notificationService: LocationNotificationServiceUseCaseProtocol
    
    private weak var coordinator: LocationNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperLocationNotificationUseCaseProtocol,
         coordinator: LocationNotificationCoordinatorProtocol,
         dataWorker: LocationNotificationDataWorkerUseCaseProtocol,
         fileDataWorker: LocationNotificationFileDataWorkerUseCaseProtocol,
         notificationService: LocationNotificationServiceUseCaseProtocol,
         dto: LocationNotificationDTO? = nil) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.dataWorker = dataWorker
        self.fileDataWorker = fileDataWorker
        self.notificationService = notificationService
        self.dto = dto
        
        bindkeyboardHelper()
        bindEdit()
    }
    
    private func bindkeyboardHelper() {
        keyboardHelper.onWillShow { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }.onWillHide { [weak self] frame in
            self?.keyboardFrameChanged?(frame)
        }
    }
    
    private func bindEdit() {
        guard let dto else { return }
        editTitle = dto.title
        editComment = dto.subtitle
        takeImage(for: dto.imagePathStr)
        
        locationProperties.latitude = dto.latitude
        locationProperties.longitude = dto.longitude
        locationProperties.radius = dto.radius
        
    }
    
    func createDidTap(title: String?, comment: String?) {
        
        guard
            let locSet = checkValid(title: title, comment: comment),
            let latitude = locationProperties.latitude,
            let longitude = locationProperties.longitude,
            let radius = locationProperties.radius
        else { return }
        
        let newID = UUID().uuidString
        

        let newDTO = LocationNotificationDTO(date: Date(),
                                             id: newID,
                                             title: locSet.title,
                                             subtitle: locSet.comment,
                                             latitude: latitude,
                                             longitude: longitude,
                                             imagePathStr: newID,
                                             radius: radius)

        dto?.title = locSet.title
        dto?.subtitle = locSet.comment
        dto?.latitude = latitude
        dto?.longitude = longitude
        dto?.radius = radius

        notificationService.updateOrCreate(
            dto: dto ?? newDTO,
            circleRegion: creatCircularRegion(with: dto?.id ?? newID),
            notifyOnEntry: true,
            notifyOnExit: false,
            repeats: false)
        
        saveImage(image: editImage ?? UIImage(), for: dto?.id ?? newID)
        
        dataWorker.updateOrCreate(dto: dto ?? newDTO)
        
        self.coordinator?.finish()
        
    }
    
    func locationImageDidTap() {
        coordinator?.editMap(locationProperties: locationProperties,
                             delegate: self)
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func saveImage(image: UIImage, for key: String) {
        fileDataWorker.save(image: image, id: key)
    }
    
    private func takeImage(for key: String) {
        fileDataWorker.getImage(id: key) { [weak self] image in
            self?.editImage =  image ?? .Home.map
            self?.locationProperties.screenLoc = image ??  .Home.map
        }
    }
    
    private func checkValid(title: String?,
                            comment: String?) -> LocSet? {
        var dateSet: LocSet
        guard
            let title,
            title != "",
            title != "Enter Title",
            let comment
        else {
            errorValidation()
            return nil
        }
        
        dateSet.title = title
        dateSet.comment = comment
        
        if comment == "Enter Comment" {
            dateSet.comment = ""
        }

        return dateSet
        
    }
    
    private func errorValidation(isTitleValid: Bool = false,
                                 isDateValid: Bool = false) {
        catchTitleError?(isTitleValid ? nil : "Enter Title")
    }
    
    func updateLocationProperties(_ properties: LocationProperties) {
        self.locationProperties = properties
        editImage = properties.screenLoc
        locImage?(properties.screenLoc)
    }
    
    private func creatCircularRegion(with id: String) -> CLCircularRegion? {
        guard
            let latitude = locationProperties.latitude,
            let longitude = locationProperties.longitude,
            let radius = locationProperties.radius
        else { return nil }
        
        let distanceRadius = CLLocationDistance(radius)
        let mapRegion =  CLLocationCoordinate2D(latitude: latitude,
                                                longitude: longitude)
        let circleRegion = CLCircularRegion(center: mapRegion,
                                            radius: distanceRadius,
                                            identifier: id)
        return circleRegion
    }
    
}


