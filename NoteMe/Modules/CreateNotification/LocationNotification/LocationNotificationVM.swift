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

protocol LocationNotificationStorageUseCaseProtocol {
    func create(dto: LocationNotificationDTO, 
                complition: @escaping (Bool) -> Void)
    func updateOrCreate(dto: Storage.LocationNotificationDTO,
                        complition: @escaping (Bool) -> Void)
}

protocol LocationDelegate {
    func updateLocationProperties(_ properties: LocationProperties)
}

final class LocationNotificationVM: LocationNotificationViewModelProtocol,
                                    LocationDelegate {
//    var imageCache = NSCache<NSString, UIImage>()
    
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
    private let storage: LocationNotificationStorageUseCaseProtocol
    private var dto: LocationNotificationDTO?
    
    private weak var coordinator: LocationNotificationCoordinatorProtocol?
    
    init(keyboardHelper: KeyboardHelperLocationNotificationUseCaseProtocol,
         coordinator: LocationNotificationCoordinatorProtocol,
         storage: LocationNotificationStorageUseCaseProtocol,
         dto: LocationNotificationDTO? = nil) {
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.storage = storage
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
        editImage = takeImage(for: dto.imagePathStr).image
        
        locationProperties.latitude = dto.latitude
        locationProperties.longitude = dto.longitude
        locationProperties.radius = dto.radius
        locationProperties.screenLoc = takeImage(for: dto.imagePathStr).image
        
    }
    
    func createDidTap(title: String?, comment: String?) {
        
        guard 
            let locSet = checkValid(title: title, comment: comment),
            let latitude = locationProperties.latitude,
            let longitude = locationProperties.longitude,
            let radius = locationProperties.radius
        else { return }
        
        let id = UUID().uuidString

        let newDTO = LocationNotificationDTO(date: Date(),
                                             id: id,
                                             title: locSet.title,
                                             subtitle: locSet.comment,
                                             latitude: latitude,
                                             longitude: longitude,
                                             imagePathStr: id,
                                             radius: radius)

        dto?.title = locSet.title
        dto?.subtitle = locSet.comment
        dto?.latitude = latitude
        dto?.longitude = longitude
        dto?.radius = radius
        dto?.imagePathStr = id
        
        creatRequest(identifire: id,
                     context: createContext(title: locSet.title,
                                            body: locSet.comment))
        saveImage(image: editImage ?? UIImage(), for: id)
        
//        AppCoordinator.cach.setObject(editImage ?? UIImage(), forKey: id as NSString)
        
        storage.updateOrCreate(dto: dto ?? newDTO) { complition in
            print(complition)
        }
        self.coordinator?.finish()
        
    }
    
    func locationImageDidTap() {
        print(locationProperties.radius, locationProperties.latitude)
        
        coordinator?.editMap(locationProperties: locationProperties,
                             delegate: self)
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
    
    private func saveImage(image: UIImage, for key: String) {
        let myImageView = UIImageView(image: image)
        let imageData = myImageView.image!.pngData()
        UserDefaults.standard.set(imageData, forKey: key)
    }
    
    private func takeImage(for key: String) -> UIImageView {
        let data: NSData = UserDefaults.standard.object(forKey: key) as! NSData
        return UIImageView(image: UIImage(data: data as Data))
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
    
    private func createContext(title: String,
                               body: String?) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body ?? ""
        return content
    }
    
    private func creatRequest(identifire id: String, context: UNMutableNotificationContent) {
        guard
            let latitude = locationProperties.latitude,
            let longitude = locationProperties.longitude,
            let radius = locationProperties.radius
        else { return }
        
        let distanceRadius = CLLocationDistance(radius)
        let mapRegion =  CLLocationCoordinate2D(latitude: latitude,
                                                longitude: longitude)
        let id = UUID().uuidString
        let circleRegion = CLCircularRegion(center: mapRegion,
                                            radius: distanceRadius,
                                            identifier: id)
        circleRegion.notifyOnEntry = true
        circleRegion.notifyOnExit = false
        
        let triger = UNLocationNotificationTrigger(region: circleRegion,
                                                   repeats: false)
        let request = UNNotificationRequest(identifier: id, content: context, trigger: triger)
        
//        let notification = NotificationRequest(triger: triger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}


//public class ImageCache {
//    
//    static var cach = NSCache<NSString, UIImage>()
//    
//}
