//
//  LocationNotificationVC.swift
//  NoteMe
//
//  Created by George Popkich on 16.02.24.
//

import UIKit
import SnapKit

@objc protocol LocationNotificationViewModelProtocol {
    func createDidTap(title: String?, comment: String?)
    @objc func cancelDidTap()
}

@available(iOS 13.4, *)
final class LocationNotificationVC: UIViewController {
    
    private lazy var contentView: UIView = .content()
    private lazy var infoView: UIView = .info()
    
    private lazy var titleLabel: UILabel = .bold("Create Location Notification", 17.0, .appText)
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        setupConstrains()
        swipeGesture()
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func swipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.infoView.addGestureRecognizer(swipeDown)
        self.contentView.addGestureRecognizer(swipeDown)
    }
     
}
