//
//  DarkModeScreen.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 10/05/23.
//

import UIKit

protocol DarkModeScreenProtocol: AnyObject {
    func tappedSwitchValueChanged(_ sender: Any)
}

class DarkModeScreen: UIView {
    
    private weak var delegate: DarkModeScreenProtocol?
    
    public func delegate(delegate: DarkModeScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isOn = false
        mySwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return mySwitch
    }()
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        self.delegate?.tappedSwitchValueChanged(mySwitch.isOn)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mySwitch)
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.mySwitch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.mySwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
