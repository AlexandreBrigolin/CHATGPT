//
//  DarkModeCellScreen.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 17/06/23.
//

import UIKit

enum Key: String {
    case isNight = "isNight"
}

class DarkModeCellScreen: UIView {
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 0.7
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 8
        image.tintColor = .white
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isOn = (UserDefaults.standard.value(forKey: Key.isNight.rawValue) as? Bool) ?? true
        mySwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return mySwitch
    }()

    @objc func switchValueChanged(_ sender: UISwitch) {
        NotificationCenter.default.post(name: Notification.Name("SwitchStateChangedNotification"), object: sender.isOn)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addElemenets()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElemenets() {
        addSubview(iconImageView)
        addSubview(descriptionLabel)
        addSubview(mySwitch)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 10),
            
            mySwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mySwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
