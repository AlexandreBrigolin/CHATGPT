//
//  ConfigProfileVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 05/05/23.
//

import UIKit

class ConfigProfileVC: UIViewController {
    
    var screen: ConfigProfileScreen?
    
    override func loadView() {
        self.screen = ConfigProfileScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.configTextFieldDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), style: .done, target: self, action: #selector(tappedBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func tappedBackButton(){
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ConfigProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        
        return textField.resignFirstResponder()
    }
}
