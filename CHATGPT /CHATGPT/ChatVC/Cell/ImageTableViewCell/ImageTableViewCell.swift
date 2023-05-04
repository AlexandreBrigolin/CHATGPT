//
//  ImageTableViewCell.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 03/05/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ImageTableViewCell.self)
    
    lazy var contactMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .incomingColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners =  [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        transform = CGAffineTransform(scaleX: 1, y: -1)
        selectionStyle = .none
        backgroundColor = .backGround
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(contactMessageView)
        contactMessageView.addSubview(customImageView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            contactMessageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contactMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contactMessageView.widthAnchor.constraint(equalToConstant: 250),
            contactMessageView.heightAnchor.constraint(equalToConstant: 250),
            
            customImageView.leadingAnchor.constraint(equalTo: contactMessageView.leadingAnchor, constant: 15),
            customImageView.topAnchor.constraint(equalTo: contactMessageView.topAnchor, constant: 15),
            customImageView.bottomAnchor.constraint(equalTo: contactMessageView.bottomAnchor, constant: -15),
            customImageView.trailingAnchor.constraint(equalTo: contactMessageView.trailingAnchor, constant: -15),
        ])
    }
    
    
    public func setupCell(data: Message) {
        guard let url = URL(string: data.urlImage ?? "") else { return }
        customImageView.loadImageFromURL(url, placeholder: UIImage(systemName: "pencil.tip.crop.circle"), errorImage: UIImage(systemName: "eraser.fill"))
    }
    
    
}
