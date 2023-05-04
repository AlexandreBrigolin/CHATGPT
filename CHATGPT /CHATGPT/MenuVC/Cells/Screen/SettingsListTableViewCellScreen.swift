//
//  SettingsListTableViewCellScreen.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

class SettingsListTableViewCellScreen: UIView {
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 17.5
        
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var flowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = ">"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
     addSubview(iconImageView)
     addSubview(descriptionLabel)
     addSubview(flowLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 5),
            
            flowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            flowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            
        ])
    }
}
