//
//  LoadingView.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 02/05/23.
//

import UIKit

class LoadingView {
    
    private let containerView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    private let messageLabel = UILabel()
    
    enum IndicatorStyle {
        case large, medium
    }
    
    let controller: UIViewController
    var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.3)
    var indicatorStyle: IndicatorStyle = .large
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func show(message: String? = nil, indicatorStyle: IndicatorStyle = .large) {
        containerView.frame = controller.view.frame
        containerView.backgroundColor = backgroundColor
        
        activityIndicator.style = getIndicatorStyle(indicatorStyle)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        
        containerView.addSubview(activityIndicator)
        
        if let message = message {
            messageLabel.text = message
            messageLabel.textColor = .gray
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            
            containerView.addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 40),
                messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
        }
        
        controller.view.addSubview(containerView)
        
        activityIndicator.center = containerView.center
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
    private func getIndicatorStyle(_ style: IndicatorStyle) -> UIActivityIndicatorView.Style {
        switch style {
        case .large:
            return .large
        case .medium:
            return .medium
        }
    }
}
