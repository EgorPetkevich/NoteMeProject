//
//  TimeCell.swift
//  NoteMe
//
//  Created by George Popkich on 26.02.24.
//

import UIKit
import Storage

final class TimerCell: UITableViewCell {
    
    var buttonDidTap: ((_ sender: UIButton) -> Void)?
    
    private var dto: TimerNotificationDTO?
    
    private lazy var content: UIView = .content()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .Home.timer
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont(15.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .appRegularFont(13.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .appTitleFont.withSize(25.0)
        label.textColor = .appText
        return label
    }()
    
    private lazy var editButton: UIButton =
        .editNotificationButton()
        .withAction(self, #selector(editButtonDidTap))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setup(_ type: TimerNotificationDTO) {
        titleLabel.text = type.title
        subtitleLabel.text = type.subtitle
        self.dto = type
        runTimer()
        setTimerLabel()
    }

    func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(content)
        
        content.cornerRadius = 5.0
        content.setShadow()
        content.addSubview(infoImageView)
        content.addSubview(titleLabel)
        content.addSubview(subtitleLabel)
        content.addSubview(editButton)
        content.addSubview(timerLabel)
    }
    
    private func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(120.0)
        }
        
        content.snp.makeConstraints { make in
            make.height.equalTo(110.0)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo( self.contentView.snp.top).offset(10.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.left.equalTo(infoImageView.snp.right).offset(8.0)
            make.height.equalTo(17.0)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            make.left.equalTo(infoImageView.snp.right).offset(8.0)
            make.height.equalTo(15.0)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(30.0)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().offset(16.0)
            make.size.equalTo(50.0)
        }
        
        editButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.right.top.equalToSuperview().inset(16.0)
        }
    }
    
    @objc private func editButtonDidTap(sender: UIButton) {
        buttonDidTap?(sender)
    }
    
    private func setTimerLabel() {
        guard let timeLeft = dto?.timeLeft else { return }
        
        if timeLeft > 0 {
            let time = NSInteger(timeLeft)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)
            timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d",
                                     hours,
                                     minutes,
                                     seconds)
            return
        }
    }

      
      private func runTimer() {

          Timer.scheduledTimer(withTimeInterval: 1,
                               repeats: true) { [weak self] timer in
              if NSInteger(self?.dto?.timeLeft ?? 0.0) > 0 {
                  self?.setTimerLabel()
              } else {
                  self?.timerLabel.text = "00:00:00"
                  timer.invalidate()
                  return
              }
          }
      }
    
    
}

