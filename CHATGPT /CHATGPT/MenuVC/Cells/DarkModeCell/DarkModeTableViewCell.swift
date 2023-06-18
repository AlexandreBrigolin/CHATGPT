//
//  DarkModeTableViewCell.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 17/06/23.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: DarkModeTableViewCell.self)
    
    lazy var screen: DarkModeCellScreen = {
        let view = DarkModeCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        self.contentView.addSubview(self.screen)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: self.topAnchor),
            screen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    public func setupCell(data: Menu) {
        screen.descriptionLabel.text = data.descriptionText
        screen.iconImageView.image = data.descriptionImage
    }
}
