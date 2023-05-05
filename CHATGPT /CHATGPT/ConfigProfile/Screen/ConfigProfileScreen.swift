//
//  ConfigProfileScreen.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 05/05/23.
//

import UIKit

class ConfigProfileScreen: UIView {
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "person.circle")
        image.backgroundColor = .backGround
        image.tintColor = .white
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
//    lazy var nameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.text = "Bárbara Brigolin"
//        return label
//    }()
    
    lazy var editNameTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .backGround
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.text = "Bárbara"
        tf.textColor = .white
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 7
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        addSubview(profileImageView)
        addSubview(editButton)
//        addSubview(nameLabel)
        addSubview(editNameTextfield)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.editNameTextfield.delegate = delegate
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            editButton.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 2),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        
//            nameLabel.topAnchor.constraint(equalTo: self.editButton.bottomAnchor, constant: 15),
//            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            editNameTextfield.topAnchor.constraint(equalTo: self.editButton.bottomAnchor, constant: 30),
            editNameTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            editNameTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            editNameTextfield.heightAnchor.constraint(equalToConstant: 40),

        ])
    }
}
