//
//  LoadingView.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 02/05/23.
//

import UIKit

class LoadingView {
    
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    public  func show() {
        if let window = UIApplication.shared.keyWindow {
            containerView.frame = window.frame
            containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            activityIndicator.style = UIActivityIndicatorView.Style.large
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
            
            containerView.addSubview(activityIndicator)
            window.addSubview(containerView)
            
            activityIndicator.center = containerView.center
        }
    }
    
    public func hide() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
