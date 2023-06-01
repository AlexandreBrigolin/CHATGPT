//
//  ProfileTableViewCellScreen.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import UIKit

class ProfileTableViewCellScreen: UIView {
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "person.circle")
        image.backgroundColor = .backGround
        image.tintColor = .white
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nameUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(nameUserLabel)
        addSubview(ageLabel)
        addSubview(phoneLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
    
            
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            nameUserLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 15),
            nameUserLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            nameUserLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: self.nameUserLabel.bottomAnchor, constant: 15),
            ageLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            ageLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 15),
            phoneLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
        ])
    }
}
