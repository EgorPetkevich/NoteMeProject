//
//  LocationNotificationVC.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import SnapKit

@objc protocol LocationNotificationViewModelProtocol {
    
    var editTitle: String? { get set }
    var editComment: String? { get set }
    var editImage: UIImage? { get set }
    var locImage: ((UIImage?) -> Void)? { get set }
    
    var catchTitleError: ((String?) -> Void)? { get set }
    var catchLocationError: ((String?) -> Void)? { get set }
    
    var keyboardFrameChanged: ((CGRect) -> Void)? { get set }
    
    func createDidTap(title: String?, comment: String?)
    @objc func cancelDidTap()
    @objc func locationImageDidTap()
}

@available(iOS 13.4, *)
final class LocationNotificationVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    
    var locationImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = .bold("Create Location Notification", 17.0, .appText)
    
    private lazy var locationImageButton: UIButton =
        .clearButton()
        .withAction(viewModel,
                    #selector(
                        LocationNotificationViewModelProtocol.locationImageDidTap))

    
    private lazy var createButton: UIButton =
        .yellowRoundedButton("Create")
        .withAction(self, #selector(createButtonDidTap))
    
    private lazy var cancelButton: UIButton =
        .cancelButton(.Auth.resetPassCancelButton)
        .withAction(viewModel,
                    #selector(LocationNotificationViewModelProtocol.cancelDidTap))
    
    private lazy var titleTextField: LineTextField =
    LineTextField()
        .setTitle("Title")
        .setPlaceholder("Enter Title")
    
    private lazy var commentTextView: LineTextView = LineTextView()
        .setTitle("Comment")
        .setPlaceholder("Enter Comment")

    private var viewModel: LocationNotificationViewModelProtocol

    init(viewModel: LocationNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bindError()
        bindkeyboardFrame()
        bindEditNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        setupConstrains()
        swipeGesture()
    }
    
    private func bindError() {
        viewModel.catchTitleError = { [weak self] errorText in
            self?.titleTextField.setErrorText(errorText)
        }
        viewModel.catchLocationError = { [weak self] errorText in
            
        }
    }
    
    private func bindkeyboardFrame() {
        viewModel.keyboardFrameChanged = { [weak self] frame in
            self?.keyboardFrameChanged(frame)
        }
        viewModel.keyboardFrameChanged = { [weak self] frame in
            self?.keyboardFrameChanged(frame)
        }
    }
    
    private func bindEditNotification() {
        titleTextField.text = viewModel.editTitle
        if let image = viewModel.editImage {
            locationImageView.image = image
            locationImageView.contentMode = .scaleAspectFill
        }else {
            locationImageView.image = .Home.map
        }
        viewModel.locImage = { [weak self] image in
            self?.locationImageView.image = image
        }
        
        if viewModel.editComment != nil {
            commentTextView.text = viewModel.editComment
            commentTextView.textColor = .appText
        }
    }
    
    private func setup() {
        view.backgroundColor = .appBackground
        view.addSubview(contentView)
        view.addSubview(createButton)
        view.addSubview(cancelButton)
  
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        
        infoView.addSubview(titleTextField)
        infoView.addSubview(commentTextView)
        infoView.addSubview(locationImageView)
        infoView.addSubview(locationImageButton)
        
    }
    
    private func setupConstrains() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(createButton.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
        }
         
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16.0)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(titleTextField.snp.bottom).inset(-16.0)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(commentTextView.snp.bottom).inset(-16.0)
            make.bottom.equalToSuperview().inset(16.0)
            make.height.equalTo(150.0)
        }
        
        locationImageButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.top.equalTo(commentTextView.snp.bottom).inset(-16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(45.0)
        }
    }

    @objc func createButtonDidTap() {
        viewModel.createDidTap(title: titleTextField.text,
                               comment: commentTextView.text)
    }
    
    @objc func hideKeyboardOnSwipeDown() {
        self.view.endEditing(true)
    }
    
}



extension LocationNotificationVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, 
                           shouldRecognizeSimultaneouslyWith 
                           otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func swipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, 
                                                 action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.infoView.addGestureRecognizer(swipeDown)
        self.contentView.addGestureRecognizer(swipeDown)
    }
    
    private func keyboardFrameChanged(_ frame: CGRect) {
        let maxY = infoView.frame.maxY + contentView.frame.minY + 16.0
        let keyboardY = frame.minY - 16.0
        
        if maxY > keyboardY {
            let diff = maxY - keyboardY
            UIView.animate(withDuration: 0.25) {
                self.infoView.snp.updateConstraints { make in
                    make.centerY.equalToSuperview().offset(-diff)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
     
}
