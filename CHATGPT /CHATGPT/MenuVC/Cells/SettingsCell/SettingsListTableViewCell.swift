//
//  SettingsListTableViewCell.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

class SettingsListTableViewCell: UITableViewCell {
    
    static let identifier: String = "SettingsListTableViewCell"
    
    lazy var screen: SettingsListTableViewCellScreen = {
        let view = SettingsListTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubView()
        configConstraints()
    }
    
    func configSubView() {
        self.addSubview(self.screen)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            self.screen.topAnchor.constraint(equalTo: self.topAnchor),
            self.screen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.screen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.screen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    public func setupCell(data: Menu) {
        screen.descriptionLabel.text = data.descriptionText
        screen.iconImageView.image = data.descriptionImage
    }
}
