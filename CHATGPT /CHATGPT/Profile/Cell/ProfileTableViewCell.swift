//
//  ProfileTableViewCell.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier: String = "ProfileTableViewCell"
    
    var screen: ProfileTableViewCellScreen = ProfileTableViewCellScreen()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configConstraints()
    }
    
    private func addSubView() {
        screen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(screen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: self.topAnchor),
            screen.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    public func setupCell(data: ProfileUser) {
        screen.profileImageView.image = UIImage(named: data.prifileImage ?? "")
        screen.nameLabel.text = "Nome: \(data.profileUserNameUser ?? "")"
        screen.nameUserLabel.text = "Usuário: \(data.nameUser ?? "")"
        screen.ageLabel.text = "Idade: \(data.ageUser ?? "")"
        screen.phoneLabel.text = "Phone: \(data.phoneUser ?? "")"
    }
}
